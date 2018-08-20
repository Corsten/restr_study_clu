class AtomItems
  def self.items(hash)
    items = []
    items = [hash[:feed][:entry]] if hash[:feed]
    items.each do |item|
      item[:link] = item[:link][0][:href] if item[:link]
    end
    items
  end
end