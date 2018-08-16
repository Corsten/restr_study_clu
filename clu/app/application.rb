require_relative './listener'
require_relative './feeds'
require_relative './reader/reader'
require_relative './converter/hash'
require 'open-uri'

options = Listener.listen(ARGV)

if !options[:path].nil?
  doc = Reader.read(options[:path])
  #convert to hash array
  hash = ToHash.from_xml(doc)

  puts hash

end

#puts "Hello, #{options[:url]}" if options[:url]