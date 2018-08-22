class RevertHandler
  def self.can_handle?(options)
    options[:revert]
  end

  def handle!(data)
    data[:items]&.reverse!
    data
  end
end
