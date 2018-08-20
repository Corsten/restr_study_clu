class Handler
  def initialize(options)
    @options = options
  end

  def item(data)

  end

  def process(data)
    items =
    items = revert(items) unless @options[:revert].nil?
    items = tsort(items) unless @options[:tsort].nil?
    items
  end

  def tsort(items)
    items.sort_by! { |item| DateTime.parse(item[:published]).to_time.to_i }
  end

  def revert(items)
    items.reverse!
  end
end