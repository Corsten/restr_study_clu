require_relative './listener'
require_relative './feeds'
require_relative './reader/reader'
require 'open-uri'

options = Listener.listen(ARGV)

if !options[:path].nil?
  source_type = Reader.read(options[:path])
end

#puts "Hello, #{options[:url]}" if options[:url]