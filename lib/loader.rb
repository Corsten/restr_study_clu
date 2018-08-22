class Loader
  def initialize(root)
    @root = root
  end

  def load(directory = '')
    objects = []
    Dir.new("#{@root}/#{directory}/").entries.each do |file|
      if File.file?("#{@root}/#{directory}/#{file}")
        objects.push(Object.const_get(File.basename(file, '.rb').split('_').collect(&:capitalize).join))
      end
    end
    objects
  end
end