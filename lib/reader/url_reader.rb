require 'nokogiri'

class UrlReader
  def self.can_read?(source)
    uri = URI.parse(source)
    protocols = %w[http https]
    protocols.include? uri.scheme
  end

  def read(source)
    Nokogiri::XML(open(source))
  end
end