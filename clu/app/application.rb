require_relative './listener'

options = Listener.parse(ARGV)

if options[:url].present?

end

puts "Hello, #{options[:url]}" if options[:url]