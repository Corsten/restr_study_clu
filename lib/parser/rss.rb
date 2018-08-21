class Rss
  def self.prepare_items(data)
    data[:items] = []
    data[:channel][:item]&.each do |item|
      item[:id] = item.delete(:guid) if item[:guid]
      item[:published] = item.delete(:pubDate) if item[:pubDate]
      item[:additional] = item.delete(:enclosure) if item[:enclosure]
      (data[:items] ||= []).push(item)
    end
    data
  end
end