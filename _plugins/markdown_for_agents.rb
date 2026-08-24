require "cgi"
require "json"
require "nokogiri"
require "reverse_markdown"

module MarkdownForAgents
  NON_CONTENT_SELECTOR = [
    "nav",
    "header",
    "footer",
    "script",
    "style",
    "noscript",
    "template",
    "form",
    "button",
    "canvas",
    "svg",
    ".pagination",
    ".github-corner",
    "[hidden]",
    "[aria-hidden='true']"
  ].join(", ").freeze

  module_function

  def convert(html)
    document = Nokogiri::HTML.parse(html)
    content = document.at_css("main.site") || document.at_css("main") ||
      document.at_css("article") || document.at_css("body")
    return "" unless content

    content = content.dup
    prepare_content(content)

    markdown = ReverseMarkdown.convert(
      content.to_html,
      github_flavored: true,
      unknown_tags: :bypass
    ).strip

    [frontmatter(document), markdown].reject(&:empty?).join("\n\n") + "\n"
  end

  def prepare_content(content)
    remove_share_controls(content)
    content.css(NON_CONTENT_SELECTOR).remove
    rewrite_catalogue_links(content)
    remove_duplicate_post_title(content)
    rewrite_citation_summaries(content)
  end

  def remove_share_controls(content)
    content.css(".sharebuttons").each do |share|
      previous = share.previous_element
      previous.remove if previous&.name == "hr"
      share.remove
    end
  end

  def rewrite_catalogue_links(content)
    content.css("a.catalogue-item").each do |item|
      heading = item.at_css(".catalogue-title")
      href = item["href"]
      next if heading.nil? || href.nil?

      link = Nokogiri::XML::Node.new("a", content.document)
      link["href"] = href
      heading.children.to_a.each { |child| link.add_child(child.unlink) }
      heading.add_child(link)

      item.children.to_a.reverse_each { |child| item.add_next_sibling(child) }
      item.remove
    end
  end

  def remove_duplicate_post_title(content)
    content.css(".post").each do |post|
      title = post.at_css("h1.post-title")
      next unless title

      normalized_title = title.text.gsub(/\s+/, " ").strip
      duplicate = post.css("h1").find do |heading|
        heading != title && heading.text.gsub(/\s+/, " ").strip == normalized_title
      end
      duplicate&.remove
    end
  end

  def rewrite_citation_summaries(content)
    content.css("details.citation-block").each do |citation|
      summary = citation.at_css("summary")
      next unless summary

      label = summary.at_css("span")&.text.to_s.strip
      label = summary.text.strip if label.empty?
      citation.css(".citation-block__formats").remove

      heading = Nokogiri::XML::Node.new("h2", content.document)
      heading.content = label
      summary.replace(heading)
      citation.children.to_a.reverse_each { |child| citation.add_next_sibling(child) }
      citation.remove
    end
  end

  def frontmatter(document)
    metadata = {
      "title" => metadata_content(document, "meta[name='title']", "meta[property='og:title']") ||
        document.at_css("title")&.text,
      "description" => metadata_content(
        document,
        "meta[name='description']",
        "meta[property='og:description']"
      ),
      "image" => metadata_content(document, "meta[property='og:image']")
    }.compact.transform_values(&:strip).reject { |_key, value| value.empty? }

    return "" if metadata.empty?

    serialized = metadata.map { |key, value| "#{key}: #{JSON.generate(value)}" }
    (["---"] + serialized + ["---"]).join("\n")
  end

  def metadata_content(document, *selectors)
    selectors.each do |selector|
      value = document.at_css(selector)&.[]("content")
      return value unless value.nil? || value.strip.empty?
    end

    nil
  end

  def add_markdown_alternate(html, markdown_url)
    document = Nokogiri::HTML.parse(html)
    return html unless document.at_css("head")
    return html if document.at_css("head link[rel~='alternate'][type='text/markdown']")

    escaped_url = CGI.escapeHTML(markdown_url)
    alternate = %(  <link rel="alternate" type="text/markdown" href="#{escaped_url}" title="Markdown representation">\n)
    html.sub(%r{</head>}i, "#{alternate}</head>")
  end

  def generate(site)
    generated = 0

    Dir.glob(File.join(site.dest, "**", "*.html")).sort.each do |html_path|
      next unless File.file?(html_path)

      html = File.read(html_path, encoding: "UTF-8")
      markdown = convert(html)
      next if markdown.empty?

      markdown_path = html_path.sub(/\.html\z/, ".md")
      relative_path = markdown_path.delete_prefix(site.dest).sub(%r{\A/+}, "")
      baseurl = site.config["baseurl"].to_s.chomp("/")
      markdown_url = "#{baseurl}/#{relative_path.tr(File::SEPARATOR, "/")}"

      File.write(markdown_path, markdown, mode: "w", encoding: "UTF-8")

      linked_html = add_markdown_alternate(html, markdown_url)
      File.write(html_path, linked_html, mode: "w", encoding: "UTF-8") unless linked_html == html
      generated += 1
    end

    Jekyll.logger.info "Markdown for Agents:", "generated #{generated} representations"
  end
end

Jekyll::Hooks.register :site, :post_write do |site|
  MarkdownForAgents.generate(site)
end
