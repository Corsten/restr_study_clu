class RssItems
  def self.getItems(hash)
    items = []
    items = hash[:rss][:channel][:item] if hash[:rss]
    items
  end
end