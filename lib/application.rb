require_rel 'converter'
require_rel 'reader'
require_rel 'handler'
require_rel 'parser'
require 'open-uri'

class Application
  def self.run(options)
    unless options[:path].nil?
      #get input data
      doc = Reader.read(options[:path])
      #convert to hash
      hash = doc.nil? ? {} : Parser.to_hash(doc)
      items = hash[:rss][:channel][:item]
      #Precess manipulation with hash data. Sort, reverse, etc.
      processed_data = !items.empty? ? Handler.process(items, options) : {}
      supported_formats = %w[rss atom]
      #Output format by default is rss
      format = supported_formats.include?(options[:format]) ? options[:format] : 'rss'
      #Convert to atom or rss
      result = Converter.convert(processed_data, format)
    end
  end
end
