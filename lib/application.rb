require_rel 'converter'
require_rel 'reader'
require_rel 'handler'
require_rel 'parser'
require 'open-uri'

class Application
  def initialize(options)
    @options = options
    @readers = [FileReader, UrlReader]
  end

  def run(source)
    result = ''
    reader_object = nil
    source_data = nil

    @readers.each do |reader|
      if reader.can_read?(source)
        reader_object = reader
        break
      end
    end

    reader = reader_object.new
    source_data = reader.read(source)

    if source_data
      parser = Parser.new
      parsed_data = parser.parse(source_data)

      handler = Handler.new(revert: @options[:revert], tsort: @options[:tsort])
      processed_data = handler.process(parsed_data)

      converter = Converter.new(format: @options[:format])
      result = converter.convert(processed_data)
    end

    puts result
  end
end
