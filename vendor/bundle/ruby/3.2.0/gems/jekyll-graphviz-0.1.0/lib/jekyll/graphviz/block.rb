require "liquid/block"
require "jekyll/graphviz/renderer"

module Jekyll
  module Graphviz
    class Block < Liquid::Block
      def initialize tag_name, text, tokens
        super
        @tag_name = tag_name
        @title = text.strip
      end

      def render context
        config = context.registers[:site].config
        @renderer = Jekyll::Graphviz::Renderer.new(config["graphviz"])
        render_graph super
      end

      private

      def render_graph code
        case @tag_name
        when 'graphviz' then render_graphviz code
        when 'graph'    then render_graphviz %[graph "#{@title}" {\n#{code}\n}]
        when 'digraph'  then render_graphviz %[digraph "#{@title}" {\n#{code}\n}]
        else raise "unknown liquid tag name: #{@tag_name}"
        end
      end

      def render_graphviz code
        @renderer.render code, @title
      end
    end
  end
end
