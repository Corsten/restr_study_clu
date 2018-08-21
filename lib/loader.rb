class Loader
  def initialize(root)
    @root = root
  end

  def load(directory = '')
    objects = []
    Dir.new("#{@root}/#{directory}/").entries.each do |file|
      objects.push(File.basename(file, '.rb').split('_').collect(&:capitalize).join) if File.file?("#{@root}/#{directory}/#{file}")
    end
    objects
  end
end