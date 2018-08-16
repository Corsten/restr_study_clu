class Handler
  def self.process(items, options)
    unless options[:revert].nil?
      revert(items)
    end
    unless options[:tsort].nil?
      tsort(items)
    end
  end
  def self.tsort(items)
    items.each do ||
      puts
    end
    #items.sort_by { |kay, value| DateTime.parse(value[:pubDate].to_time.to_i) }
    #items.revers unless items.empty?
  end

  def self.revert(items)
    items.reverse!
  end
end