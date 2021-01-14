require 'tempfile'
require 'pathname'

class LatexTag < Liquid::Block
  def initialize(tag_name, input, tokens)
    super
  end

  def render(context)
    text = super
    f = Tempfile.new
    f << text
    f.flush

    job = Pathname.new(f.path).basename

    result = system( "pdflatex -interaction=nonstopmode -aux-directory=/tmp -output-directory=/tmp -jobname=#{job} #{f.path} ")
    f.unlink()
    logData = File.read("/tmp/#{job}.log")
    File.delete("/tmp/#{job}.log") if File.exist?("/tmp/#{job}.log")
    File.delete("/tmp/#{job}.aux") if File.exist?("/tmp/#{job}.aux")

    if ! result
      return "<p> ERROR GENERATING LATEX #{logData} </p>"
    end

    result = system( "pdf2svg /tmp/#{job}.pdf /tmp/#{job}.svg")
    if ! result
      return "<p> ERROR GENERATING LATEX </p>"
    end
    File.delete("/tmp/#{job}.pdf") if File.exist?("/tmp/#{job}.pdf")
    File.delete("/tmp/#{job}.aux") if File.exist?("/tmp/#{job}.aux")

    result = system( "svgo /tmp/#{job}.svg")
    if ! result
      return "<p> ERROR GENERATING LATEX </p>"
    end

    svg = File.read("/tmp/#{job}.svg")
    File.delete("/tmp/#{job}.svg") if File.exist?("/tmp/#{job}.svg")

    return svg
  end
end
Liquid::Template.register_tag('ltx', LatexTag)