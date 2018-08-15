require_relative './file_reader'
require_relative './url_reader'
require 'uri'

class Reader
  def initialize
  end

  def identifySourceType(path)
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
    sourceType = identifySourceType(path)
    FileReader.read(path) if sourceType == 'file'
    UrlReader.read(path) if sourceType == 'url'
  end
end
