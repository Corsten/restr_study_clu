class Handler
  def self.process(items, options)
    revert(items) unless options[:revert].nil?
    tsort(items) unless options[:tsort].nil?
  end

  def self.tsort(items)
    items.sort_by! { |item| DateTime.parse(item[:pubDate]).to_time.to_i }
  end

  def self.revert(items)
    items.reverse!
  end
end