require 'rss'

class AtomConverter
  DEFAULT_ID = 'Restr'
  DEFAULT_TITLE = 'Test title'
  DEFAULT_AUTHOR = 'Restr'

  def self.can_convert?(format)
    format == 'atom'
  end

  def convert(data)
    atom = RSS::Maker.make('atom') do |m|
      data[:feed]&.each do |key, value|
        if m.channel.respond_to?(key.to_s)
          m.channel.send(:"#{key.to_sym}=", value.to_s)
        end
      end

      m.channel.id = DEFAULT_ID if m.channel.id.nil?
      m.channel.title = DEFAULT_TITLE if m.channel.title.nil?
      m.channel.author = DEFAULT_AUTHOR if m.channel.author.nil?

      m.channel.updated = Time.now

      data[:items]&.each do |data_item|
        m.items.new_item do |item|
          item.id = data_item[:id] unless data_item[:id]
          item.title = data_item[:title] unless data_item[:title].nil?
          item.link = data_item[:link] unless data_item[:link].nil?
          item.updated = Time.now
          item.description = "<![CDATA[#{data_item[:description][:'#cdata-section']}]]>" unless data_item[:description].nil?
          item.published = data_item[:published] ? Time.parse(data_item[:published]) : Time.now
        end
      end
    end
    atom
  end
end
