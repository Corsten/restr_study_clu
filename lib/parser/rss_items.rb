class RssItems
  def self.items(hash)
    items = []
    items = hash[:rss][:channel][:item] if hash[:rss]
    items.each do |item|
      item[:id] = item.delete(:guid) if item[:guid]
      item[:published] = item.delete(:pubDate) if item[:pubDate]
      item[:additional] = item.delete(:enclosure) if item[:enclosure]
    end
    items
  end
end