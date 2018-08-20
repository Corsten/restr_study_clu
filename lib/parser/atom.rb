class Atom
  def self.prepare_items(hash)
    hash[:feed][:entry].each do |item|
      item[:link] = item[:link][0][:href] if item[:link]
    end
    hash
  end
end