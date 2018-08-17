require 'require_all'
require_rel 'converter'
require_rel '../bin/listener.rb'
require_rel 'reader'
require_rel 'handler'
require_rel 'parser'
require_rel 'application.rb'

Application.run
