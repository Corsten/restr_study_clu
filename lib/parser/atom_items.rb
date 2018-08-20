class AtomItems
  def self.getItems(hash)
    items = []
    items = [hash[:feed][:entry]] if hash[:feed]
    items
  end
end