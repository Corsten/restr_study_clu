require 'rss'

class RssConverter
  def self.convert(data)
    rss = RSS::Maker.make("2.0") do |m|
      data[:rss][:channel].each do |key, value|
        if m.channel.respond_to?(key.to_s)
          m.channel.send(:"#{key.to_sym}=", value.to_s)
        end
        #m.channel.key.to_s = value if key.to_s == 'about'
        #m.channel.title = value if key.to_s == 'title'
        #m.channel.link = value[0] if key.to_s == 'link'
        #m.channel.description = value if key.to_s == 'description'
        #m.channel.language = value if key.to_s == 'language'
      end
      m.channel.updated = Time.now
      data[:rss][:channel][:item].each do |data_item|
        m.items.new_item do |item|
          item.guid.content = data_item[:guid] unless data_item[:guid].nil?
          item.title = data_item[:title] unless data_item[:title].nil?
          item.link = data_item[:link] unless data_item[:link].nil?
          item.description = "<![CDATA[#{data_item[:description][:'#cdata-section']}]]>" unless data_item[:description].nil?
          item.pubDate = data_item[:pubDate] unless data_item[:pubDate].nil?
          unless data_item[:enclosure].nil?
            if data_item[:enclosure].kind_of?(Array)
              data_item[:enclosure].each do |enclosure_item|
                item.enclosure.url = enclosure_item[:url] unless enclosure_item[:url].nil?
                item.enclosure.length = enclosure_item[:length] unless enclosure_item[:length].nil?
                item.enclosure.type = enclosure_item[:type] unless enclosure_item[:type].nil?
              end
            else
              item.enclosure.url = data_item[:enclosure][:url] unless data_item[:enclosure][:url].nil?
              item.enclosure.length = data_item[:enclosure][:length] unless data_item[:enclosure][:length].nil?
              item.enclosure.type = data_item[:enclosure][:type] unless data_item[:enclosure][:type].nil?
            end
          end
        end
      end
    end
    #puts rss
    rss
  end
end