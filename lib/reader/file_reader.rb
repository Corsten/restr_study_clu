require 'nokogiri'

class FileReader
  def self.can_read?(source)
    File.file?(source)
  end

  def read(source)
    File.open(source) { |f| Nokogiri::XML(f) }
  end
end
