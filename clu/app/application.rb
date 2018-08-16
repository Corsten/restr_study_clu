require_relative './listener'
require_relative './feeds'
require_relative './reader/reader'
require_relative './converter/hash'
require_relative './handler/handler'
require 'open-uri'

options = Listener.listen(ARGV)

unless options[:path].nil?
  #get xml
  doc = Reader.read(options[:path])
  #convert to hash
  hash = ToHash.from_xml(doc)

  items = hash[:rss][:channel][:item]

  Handler.process(items, options) if !items.empty?
end
