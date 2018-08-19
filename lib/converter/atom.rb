

class AtomConverter
  def self.convert(hash, items)
    atom = RSS::Maker.make('atom') do |m|
      m.channel.title = "Marat"
      m.channel.id = "Rest"
      m.channel.updated = Time.now
      m.channel.author = "Restr"

      items.each do |data_item|
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
    atom
  end
end
