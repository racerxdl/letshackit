require "digest/md5"
require "open3"

module Jekyll
  class Graphviz::Renderer

    DIV_CLASS_ATTR = "graphviz-wrapper"
    DEFAULT_OPTIONS = "-Tsvg"
    DEFAULT_EXECUTABLE = "dot"

    def initialize config = nil
      @config = config || {}
    end

    def render code, title = nil
      title = gen_title(title, code)
      svg = generate_svg code
      svg = remove_declarations svg
      svg = remove_xmlns_attrs svg
      svg = add_desc_attrs svg, title
      svg = insert_desc_elements svg, title, code
      svg = wrap_with_div svg
      svg
    end

    private

    def gen_title title, code
      if title.nil? or title.empty?
      then "graphviz-#{digest code}"
      else title
      end
    end

    def digest str
      Digest::MD5.hexdigest str
    end

    def generate_svg code
      svg, status = Open3.capture2(cmd, stdin_data: code, binmode: true)
      raise "Non-zero exit status '#{cmd}': #{status}" unless status.success?
      svg.force_encoding 'UTF-8'
      svg
    end

    def remove_declarations svg
      svg
        .sub(/<!DOCTYPE .+?>/im,'')
        .sub(/<\?xml .+?\?>/im,'')
    end

    def remove_xmlns_attrs svg
      svg
        .sub(%[xmlns="http://www.w3.org/2000/svg"], '')
        .sub(%[xmlns:xlink="http://www.w3.org/1999/xlink"], '')
    end

    def add_desc_attrs svg, title
      svg
        .sub("<svg", %[<svg aria-label="#{CGI::escapeHTML title}"])
        .sub("<svg", %[<svg role="img"])
    end

    def insert_desc_elements svg, title, desc
      inserted_elements = %[<title>#{CGI::escapeHTML title}</title>\n] +
                          %[<desc>#{CGI::escapeHTML desc}</desc>\n]
      svg.sub(/(<svg [^>]*>)/, "\\1\n#{inserted_elements}")
    end

    def wrap_with_div svg
      %[<div class="#{DIV_CLASS_ATTR}">#{svg}</div>]
    end

    def cmd
      "#{exec} #{opts}"
    end

    def exec
      @config && @config["executable"] || DEFAULT_EXECUTABLE
    end

    def opts
      @config && @config["options"] || DEFAULT_OPTIONS
    end
  end
end
