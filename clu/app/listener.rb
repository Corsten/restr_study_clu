require 'optparse'

class Listener
  def self.listen(args)
    options = {}

    opts = OptionParser.new do |opts|
      opts.on('-p', '--path PATH', 'The path for input items') do |path|
        options[:path] = path
      end
      opts.on('-h', '--help', 'Show help message') do ||
        puts opts
      end
      opts.on('-o', '--out', 'Result format type. atom or rss') do ||
        puts opts
      end
    end

    opts.parse(args)

    options
  end
end
