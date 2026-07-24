require 'cgi'

module Jekyll
  module CitationFilters
    BIBTEX_ESCAPES = {
      '\\' => '{\\textbackslash}',
      '{' => '\\{',
      '}' => '\\}',
      '%' => '\\%',
      '$' => '\\$',
      '#' => '\\#',
      '&' => '\\&',
      '_' => '\\_',
      '~' => '{\\textasciitilde}',
      '^' => '{\\textasciicircum}'
    }.freeze

    def bibtex_escape(value)
      CGI.unescapeHTML(value.to_s).gsub(/\s+/, ' ').strip.gsub(/[\\{}%$#&_~^]/, BIBTEX_ESCAPES)
    end

    def citation_title_punctuate(value)
      title = value.to_s.strip
      return title if title.end_with?('.', '?', '!')

      "#{title}."
    end
  end
end

Liquid::Template.register_filter(Jekyll::CitationFilters)
