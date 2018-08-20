require_rel 'converter'
require_rel 'reader'
require_rel 'handler'
require_rel 'parser'
require 'open-uri'

class Application

  def self.run(options)
    result = ''
    reader = Reader.new(options)
    source_data = reader.read

    if source_data
      parser = Parser.new
      data = parser.parse(source_data)
      items = parser.items(data)

      handler = Handler.new(options)
      items = handler.process(items)

      converter = Converter.new(options)
      result = converter.convert({data:data, items:items})
    end

    puts result

  end
end
