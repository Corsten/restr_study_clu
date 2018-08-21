require_rel 'converter'
require_rel 'reader'
require_rel 'handler'
require_rel 'parser'
require_rel 'loader'
require 'open-uri'

class Application
  def initialize(options)
    @options = options
  end

  def reader_factory(loader, source)
    reader_objects = loader.load('reader')
    reader_object = Object.const_get(reader_objects.find { |reader| Object.const_get(reader).can_read?(source) })
    reader = reader_object.new
    reader
  end

  def parser_factory(loader, source_data)
    parser_objects = loader.load('parser')
    parser_object = Object.const_get(parser_objects.find { |parser| Object.const_get(parser).can_pars?(source_data) })

    parser = parser_object.new
    parser
  end

  def run(source)
    result = ''
    source_data = nil

    loader = Loader.new('./lib')

    reader = reader_factory(loader, source)
    source_data = reader.read(source)

    if source_data
      parser = parser_factory(loader, source_data)
      parsed_data = parser.parse(source_data)

      handler = Handler.new(revert: @options[:revert], tsort: @options[:tsort])
      processed_data = handler.process(parsed_data)

      converter = Converter.new(format: @options[:format])
      result = converter.convert(processed_data)
    end

    #puts result
  end
end
