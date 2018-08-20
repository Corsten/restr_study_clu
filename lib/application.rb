require_rel 'converter'
require_rel 'reader'
require_rel 'handler'
require_rel 'parser'
require 'open-uri'

class Application
  @supported_formats = %w[rss atom]
  def self.run(options)
    unless options[:path].nil?
      #get input data
      doc = Reader.read(options[:path])
      #convert to hash
      hash = doc.nil? ? {} : Parser.to_hash(doc)
      items = Parser.get_items(hash, doc.nil? ? '' : Parser.get_input_format(doc))
      #Precess manipulation with hash data. Sort, reverse, etc.
      items = !items.empty? ? Handler.process(items, options) : []
      #Output format by default is rss
      format = @supported_formats.include?(options[:format]) ? options[:format] : 'rss'
      #Convert to atom or rss
      result = Converter.convert(hash, items, format)
      puts result
    end
  end
end
