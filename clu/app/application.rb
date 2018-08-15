require_relative './listener'
require_relative './feeds'
require_relative './reader/reader'
require 'open-uri'

options = Listener.listen(ARGV)

if options[:path].present?

  puts doc
end

#puts "Hello, #{options[:url]}" if options[:url]