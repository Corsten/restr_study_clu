require 'optparse'

class Listener
  def self.listen(args)
    options = {}

    opts = OptionParser.new do |opts|
      opts.on('-p', '--source SOURCE', 'The source for input items') do |source|
        options[:source] = source
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
      opts.on('-o', '--out FORMAT', 'Result format type. atom or rss') do |format|
        options[:format] = format
      end
    end

    opts.parse(args)

    options
  end
end
