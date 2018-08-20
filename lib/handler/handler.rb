class Handler
  def self.process(items, options)
    items = revert(items) unless options[:revert].nil?
    items = tsort(items) unless options[:tsort].nil?
    items
  end

  def self.tsort(items)
    items.sort_by! { |item| DateTime.parse(item[:published]).to_time.to_i }
  end

  def self.revert(items)
    items.reverse!
  end
end