require 'nokogiri'

class UrlReader
  def self.read(path)
    doc = Nokogiri::XML(open(path))
  end
end