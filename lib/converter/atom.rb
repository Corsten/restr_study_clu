

class AtomConverter
  def self.convert(hash, items)
    atom = RSS::Maker.make('atom') do |m|
      if !hash[:feed].nil?
        hash[:feed].each do |key, value|
          if m.channel.respond_to?(key.to_s)
            m.channel.send(:"#{key.to_sym}=", value.to_s)
          end
        end
      else
        m.channel.title = 'Test title'
        m.channel.id = 'Restr'
        m.channel.author = 'Restr'
      end

      m.channel.updated = Time.now

      items.each do |data_item|
        m.items.new_item do |item|
          item.id = data_item[:guid] ? data_item[:guid] : data_item[:id]
          item.title = data_item[:title] unless data_item[:title].nil?
          item.link = data_item[:link] ? data_item[:link] : data_item[:link][0]
          item.updated = Time.now
          item.description = "<![CDATA[#{data_item[:description][:'#cdata-section']}]]>" unless data_item[:description].nil?
          item.published = data_item[:pubDate] ? Time.parse(data_item[:pubDate]) : data_item[:published]
        end
      end
    end
    atom
  end
end
