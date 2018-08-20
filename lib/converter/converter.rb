require 'nokogiri'

class Converter
  FORMATS = %w[rss atom]

  def initialize(options)
    @options = options
  end

  def convert(data)
    format = FORMATS.include?(@options[:format]) ? @options[:format] : 'rss'
    result = AtomConverter.convert(data) if format == 'atom'
    result = RssConverter.convert(data) if format == 'rss'
    result
  end
end
