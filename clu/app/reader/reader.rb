require_relative './file_reader'
require_relative './url_reader'
require 'uri'

class Reader
  def self.identify_source_type(path)
    uri = URI.parse(path)
    if uri.scheme == 'http' or uri.scheme == 'https'
      # It is a web URL
      type = 'url'
    elsif File.file?(path)
      # It is a file
      type = 'file'
    else
      type = 'unknown'
      # Unknown
    end

    type
  end

  def read(path)
    source_type = identify_source_type(path)
    doc = FileReader.read(path) if source_type == 'file'
    doc = UrlReader.read(path) if source_type == 'url'
    doc
  end
end
