require 'rss'

class RssConverter
  def self.convert(data)
    rss = RSS::Maker.make("2.0") do |m|
      unless data[:rss].nil?
        data[:rss][:channel]&.each do |key, value|
          if m.channel.respond_to?(key.to_s)
            m.channel.send(:"#{key.to_sym}=", value.to_s)
          end
        end
      end

      m.channel.about = 'Rest test rss converter' if m.channel.about.nil?
      m.channel.title = 'Test title' if m.channel.title.nil?
      m.channel.link = 'Test link' if m.channel.link.nil?
      m.channel.description = 'Test description' if m.channel.description.nil?
      m.channel.language = 'Test language' if m.channel.language.nil?

      m.channel.updated = Time.now

      data[:items].each do |data_item|
        m.items.new_item do |item|
          item.guid.content = data_item[:id] unless data_item[:id].nil?
          item.title = data_item[:title] unless data_item[:title].nil?
          item.link = data_item[:link] unless data_item[:link].nil?
          item.description = "<![CDATA[#{data_item[:description][:'#cdata-section']}]]>" unless data_item[:description].nil?
          item.pubDate = data_item[:published] ? data_item[:published] : Time.now
          unless data_item[:additional].nil?
            if data_item[:additional].kind_of?(Array)
              data_item[:additional].each do |enclosure_item|
                item.enclosure.url = enclosure_item[:url] unless enclosure_item[:url].nil?
                item.enclosure.length = enclosure_item[:length] unless enclosure_item[:length].nil?
                item.enclosure.type = enclosure_item[:type] unless enclosure_item[:type].nil?
              end
            else
              item.enclosure.url = data_item[:additional][:url] unless data_item[:additional][:url].nil?
              item.enclosure.length = data_item[:additional][:length] unless data_item[:additional][:length].nil?
              item.enclosure.type = data_item[:additional][:type] unless data_item[:additional][:type].nil?
            end
          end
        end
      end
    end
    rss
  end
end