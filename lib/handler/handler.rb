class Handler
  def initialize(options)
    @options = options
  end

  def process(data)
    if data[:items]
      data[:items] = revert(data[:items]) unless @options[:revert].nil?
      data[:items] = tsort(data[:items]) unless @options[:tsort].nil?
    end
    data
  end

  def tsort(items)
    items.sort_by! { |item| DateTime.parse(item[:published]).to_time.to_i }
  end

  def revert(items)
    items.reverse!
  end
end