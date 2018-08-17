require 'require_all'
require_rel '../lib/application.rb'
require_rel '../lib/listener.rb'

options = Listener.listen(ARGV)
Application.run(options)
