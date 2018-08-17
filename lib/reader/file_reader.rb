require 'nokogiri'

class FileReader
  def self.read(path)
    File.open(path) { |f| Nokogiri::XML(f) }
  end
end
