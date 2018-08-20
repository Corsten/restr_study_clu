class Rss
  def self.prepare_items(hash)
    hash[:channel][:item].each do |item|
      item[:id] = item.delete(:guid) if item[:guid]
      item[:published] = item.delete(:pubDate) if item[:pubDate]
      item[:additional] = item.delete(:enclosure) if item[:enclosure]
    end
    hash
  end
end