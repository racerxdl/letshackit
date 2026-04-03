require "jekyll"
require "jekyll/graphviz/version"
require "jekyll/graphviz/block"

module Jekyll
  module Graphviz
  end
end

Liquid::Template.register_tag('graphviz', Jekyll::Graphviz::Block)
Liquid::Template.register_tag('graph', Jekyll::Graphviz::Block)
Liquid::Template.register_tag('digraph', Jekyll::Graphviz::Block)
