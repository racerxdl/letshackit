require 'tempfile'
require 'pathname'

class WaveDromTag < Liquid::Block
  def initialize(tag_name, input, tokens)
    super
  end

  def render(context)
    text = super
    f = Tempfile.new
    f << text
    f.flush

    job = Pathname.new(f.path).basename
    result = system("node wavedrom.js -i #{f.path} 1> /tmp/#{job}.svg 2>/tmp/#{job}.log")
    logData = File.read("/tmp/#{job}.log").gsub("\n", "<BR>")
    File.delete("/tmp/#{job}.log") if File.exist?("/tmp/#{job}.log")
    f.unlink()

    if ! result
      return "<p> ERROR GENERATING WAVEDROM(#{result})<BR> #{logData} <BR><BR>#{jsonData}</p>"
    end

    svg = File.read("/tmp/#{job}.svg")
    File.delete("/tmp/#{job}.svg") if File.exist?("/tmp/#{job}.svg")
    File.delete("/tmp/#{job}.aux") if File.exist?("/tmp/#{job}.aux")

    return "<div class=\"wavedrom\">#{svg}</div>"
  end
end
Liquid::Template.register_tag('wavedrom', WaveDromTag)