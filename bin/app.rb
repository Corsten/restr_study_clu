require 'require_all'
require_rel '../lib/application.rb'
require_rel '../lib/listener.rb'

options = Listener.listen(ARGV)

application = Application.new(revert: options[:tsort], tsort: options[:tsort], format: options[:format])
application.run(options[:source])
