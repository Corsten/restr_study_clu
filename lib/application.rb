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
    readers_list = loader.load('reader')
    reader_object = readers_list.find { |reader| reader.can_read?(source) }
    reader = reader_object.new
    reader
  end

  def parser_factory(loader, source)
    parsers_list = loader.load('parser')
    parser_object = parsers_list.find { |parser| parser.can_pars?(source) }
    parser = parser_object.new
    parser
  end

  def handler_factory(loader, options)
    handler_list = loader.load('handler')
    handler_object = handler_list.find { |handler| handler.can_handle?(options) }
    handler = handler_object.new
    handler
  end

  def converter_factory(loader, format)
    converters_list = loader.load('converter')
    converter_object = converters_list.find { |parser| parser.can_convert?(format) }
    converter = converter_object.new
    converter
  end

  def run(source)
    result = ''

    object_loader = ObjectLoader.new(root_dir: './lib')

    reader = reader_factory(object_loader, source)
    source_data = reader.read(source)

    if source_data
      parser = parser_factory(object_loader, source_data)
      parsed_data = parser.parse(source_data)

      handler = handler_factory(object_loader, @options)
      processed_data = handler.handle(source_data)

      #can_handle? handler = Handler.new(revert: @options[:revert], tsort: @options[:tsort])
      #processed_data = handler.process(parsed_data)

      converter = converter_factory(object_loader, @options[:format])
      result = converter.convert(processed_data)
    end

    puts result
  end
end
