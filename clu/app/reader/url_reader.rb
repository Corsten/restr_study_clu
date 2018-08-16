class UrlReader
  def read(path)
    doc = Nokogiri::XML(open("#{options[:path]}"))
  end
end