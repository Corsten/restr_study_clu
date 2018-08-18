require 'rss'

class RssConverter
  def self.convert(data)
    rss = RSS::Maker.make("2.0") do |m|
      data[:rss][:channel].each do |key, value|
        m.channel.author = value if key.to_s == 'author'
        m.channel.about = value if key.to_s == 'about'
        m.channel.title = value if key.to_s == 'title'
        m.channel.link = value[0] if key.to_s == 'link'
        m.channel.description = value if key.to_s == 'description'
        m.channel.language = value if key.to_s == 'language'
      end
      m.channel.updated = Time.now
      data[:rss][:channel][:item].each do |data_item|
        puts data_item
        m.items.new_item do |item|
          item.guid.content = data_item[:guid] unless data_item[:guid].nil?
          item.title = data_item[:title] unless data_item[:title].nil?
          item.link = data_item[:link] unless data_item[:link].nil?
          item.description = "<![CDATA[#{data_item[:description][:'#cdata-section']}]]>" unless data_item[:description].nil?
          item.pubDate = data_item[:pubDate] unless data_item[:pubDate].nil?
          unless data_item[:enclosure].nil?
            item.enclosure.url = data_item[:enclosure][:url] unless data_item[:enclosure][:url].nil?
            item.enclosure.length = data_item[:enclosure][:length] unless data_item[:enclosure][:length].nil?
            item.enclosure.type = data_item[:enclosure][:type] unless data_item[:enclosure][:type].nil?
          end
        end
      end
    end
    #puts rss
    rss
  end
end