class TsortHandler
  def self.can_handle?(options)
    options[:tsort]
  end

  def handle!(data)
    data[:items]&.sort_by! { |item| DateTime.parse(item[:published]).to_time.to_i } if data[:items]
    data
  end
end
