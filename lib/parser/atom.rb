class Atom
  def self.prepare_items(data)
    data[:item] = []
    data[:feed][:entry]&.each do |item|
      item[:link] = item[:link][0][:href] if item[:link]
      (data[:items] ||= []).push(item)
    end
    data
  end
end