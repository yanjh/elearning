# this is myserver_control.rb
# use: r_ctrl start/stop/restart

require 'rubygems'        # if you use RubyGems
require 'daemons'

Daemons.run('xrobot.rb')