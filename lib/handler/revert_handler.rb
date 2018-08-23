class RevertHandler
  def self.can_handle?(options)
    options[:revert]
  end

  def handle(data)
    data = data.reverse
    data
  end
end
