require_rel 'concerns/xml_parser'

class AtomParser
  include XmlParser

  def self.can_parse?(doc)
    doc.root&.name == 'feed'
  end

  def parse(doc)
    doc.root ? prepare_items(XmlParser.parse(doc.root)) : {}
  end

  def prepare_items(data)
    data[:item] = []
    data[:entry]&.each do |item|
      item[:link] = item[:link][0][:href] if item[:link]
      (data[:items] ||= []).push(item)
    end
    data
  end
end