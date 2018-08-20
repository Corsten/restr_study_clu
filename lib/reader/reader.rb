require 'uri'

class Reader
  def identify_source_type(source)
    uri = URI.parse(source)
    protocols = %w[http https]
    if protocols.include? uri.scheme
      type = 'url'
    elsif File.file?(source)
      type = 'file'
    else
      type = 'unknown'
      # Unknown
    end

    type
  end

  def read(source)
    source_type = identify_source_type(source)
    doc = FileReader.read(source) if source_type == 'file'
    doc = UrlReader.read(source) if source_type == 'url'
    doc
  end
end
