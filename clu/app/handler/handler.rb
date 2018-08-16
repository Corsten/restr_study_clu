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
    puts "Call sort method"
  end

  def self.revert(items)
    puts "Call revert method"
  end
end