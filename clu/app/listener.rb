require 'optparse'

class Listener
  def self.parse(args)
    options = {}

    opts = OptionParser.new do |opts|
      opts.on('-u', '--url URL', 'The url for rss parser') do |url|
        options[:url] = url
      end
      opts.on('-h', '--help', 'Show help message') do ||
        puts opts
      end
    end

    opts.parse(args)

    options
  end
end
