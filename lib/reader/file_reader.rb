require 'nokogiri'

class FileReader
  def self.read(source)
    File.open(source) { |f| Nokogiri::XML(f) }
  end
end
