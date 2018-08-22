require_rel 'converter'
require_rel 'reader'
require_rel 'handler'
require_rel 'parser'
require_rel 'object_loader'
require 'open-uri'

class Application
  def initialize(options)
    @options = options
  end

  def reader_factory(options)
    readers_list = options[:loader].load('reader')
    reader_object = readers_list.find { |reader| reader.can_read?(options[:source]) }
    reader = reader_object.new
    reader
  end

  def parser_factory(options)
    parsers_list = options[:loader].load('parser')
    parser_object = parsers_list.find { |parser| parser.can_parse?(options[:source]) }
    parser = parser_object.new
    parser
  end

  def handler_factory(options)
    handler_list = options[:loader].load('handler')
    handler_object = handler_list.find { |handler| handler.can_handle?(options[:instructions]) }
    handler = handler_object.new
    handler
  end

  def converter_factory(options)
    converters_list = options[:loader].load('converter')
    converter_object = converters_list.find { |converter| converter.can_convert?(options[:format]) }
    converter = converter_object.new
    converter
  end

  def run(source)
    result = nil

    object_loader = ObjectLoader.new(root_dir: './lib')

    reader = reader_factory(loader: object_loader, source: source)
    source_data = reader.read(source)

    if source_data
      parser = parser_factory(loader: object_loader, source: source_data)
      parsed_data = parser.parse(source_data)

      handler = handler_factory(loader: object_loader, instructions: @options)
      processed_data = handler.handle!(parsed_data)

      converter = converter_factory(loader: object_loader, format: @options[:format])
      result = converter.convert(processed_data)
    end

    puts result
  end
end
