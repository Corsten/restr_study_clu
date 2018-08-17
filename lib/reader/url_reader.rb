require 'nokogiri'

class UrlReader
  def self.read(path)
    Nokogiri::XML(open(path))
  end
end