class Atom
  def self.prepare_items(hash)
    hash[:item] = []
    hash[:feed][:entry]&.each do |key, item|
      item[:link] = item[:link][0][:href] if item[:link]
      (hash[:items] ||= []).push(item)
    end
    hash
  end
end