class ObjectLoader
  def initialize(options)
    @root_dir = options[:root_dir]
  end

  def load(directory = '')
    objects = []
    Dir.new("#{@root_dir}/#{directory}/").entries.each do |file|
      if File.file?("#{@root_dir}/#{directory}/#{file}")
        objects.push(Object.const_get(File.basename(file, '.rb').split('_').collect(&:capitalize).join))
      end
    end
    objects
  end
end