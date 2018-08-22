require_rel 'concerns/xml_parser'

class RssParser
  include XmlParser

  def self.can_pars?(doc)
    doc.root.name == 'rss'
  end

  def parse(doc)
    doc.root ? prepare_items(XmlParser.parse(doc.root)) : {}
  end

  def prepare_items(data)
    data[:items] = []
    data[:channel][:item]&.each do |item|
      item[:id] = item.delete(:guid) if item[:guid]
      item[:published] = item.delete(:pubDate) if item[:pubDate]
      item[:additional] = item.delete(:enclosure) if item[:enclosure]
      (data[:items] ||= []).push(item)
    end
    data
  end
end