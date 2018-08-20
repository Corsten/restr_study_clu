require 'nokogiri'

class Converter
  FORMATS = %w[rss atom]

  def initialize(options)
    @options = options
  end

  def convert(options)
    format = FORMATS.include?(options[:format]) ? options[:format] : 'rss'
    result = AtomConverter.convert(options[:data], options[:items]) if format == 'atom'
    result = RssConverter.convert(options[:data], options[:items]) if format == 'rss'
    result
  end
end
