require 'nokogiri'

class Converter
  def self.convert(data, format)
    AtomConverter.convert(data) if format == "atom"
    RssConverter.convert(data) if format == "rss"
  end
end
