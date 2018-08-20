require 'uri'

class Reader
  def initialize(options)
    @options = options
  end

  def identify_source_type
    uri = URI.parse(@options[:path])
    protocols = %w[http https]
    if protocols.include? uri.scheme
      type = 'url'
    elsif File.file?(@options[:path])
      type = 'file'
    else
      type = 'unknown'
      # Unknown
    end

    type
  end

  def read
    source_type = identify_source_type
    doc = FileReader.read(@options[:path]) if source_type == 'file'
    doc = UrlReader.read(@options[:path]) if source_type == 'url'
    doc
  end
end
