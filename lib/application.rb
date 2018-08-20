require_rel 'converter'
require_rel 'reader'
require_rel 'handler'
require_rel 'parser'
require 'open-uri'

class Application

  def self.run(options)
    result = ''
    reader = Reader.new
    source_data = reader.read(options[:source])

    if source_data
      parser = Parser.new
      parsed_data = parser.parse(source_data)

      handler = Handler.new(revert: options[:revert], tsort: options[:tsort])
      processed_data = handler.process(parsed_data)

      converter = Converter.new(format: options[:format])
      result = converter.convert(processed_data)
    end

    puts result

  end
end
