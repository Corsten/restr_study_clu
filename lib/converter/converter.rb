require 'nokogiri'

class Converter
  def self.convert(hash, items, format)
    result = AtomConverter.convert(hash, items) if format == 'atom'
    result = RssConverter.convert(hash, items) if format == 'rss'
    result
  end
end
