require 'optparse'

class Listener
  def self.listen(args)
    options = {}

    opts = OptionParser.new do |opts|
      opts.on('-p', '--path PATH', 'The path for input items') do |path|
        options[:path] = path
      end
      opts.on('-r', '--revert', 'Revert items') do ||
        options[:revert] = true
      end
      opts.on('-ts', '--tsort', 'Sort items by times') do ||
        options[:tsort] = true
      end
      opts.on('-h', '--help', 'Show help message') do ||
        puts opts
      end
      opts.on('-o', '--out', 'Result format type. atom or rss') do |format|
        options[:format] = format
      end
    end

    opts.parse(args)

    options
  end
end
