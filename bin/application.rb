require_relative '../lib/app'
require 'open-uri'

options = Listener.listen(ARGV)

unless options[:path].nil?
  #get input data
  doc = Reader.read(options[:path])
  #convert to hash
  hash = Parser.to_hash(doc)

  items = hash[:rss][:channel][:item]

  #Precess manipulation with hash data. Sort, reverse, etc.
  processed_data = Handler.process(items, options) unless items.empty?

  supported_formats = ['rss', 'atom']

  #Output format by default is rss
  format = supported_formats.include?(options[:format]) ? options[:format] : 'rss'

  puts format

  #Convert to atom or rss
  result = Converter.convert(processed_data, format)
end
