require_relative '../lib/app'
require 'open-uri'

options = Listener.listen(ARGV)

unless options[:path].nil?
  #get xml
  doc = Reader.read(options[:path])
  #convert to hash
  hash = ToHash.from_xml(doc)

  items = hash[:rss][:channel][:item]

  Handler.process(items, options) unless items.empty?
end
