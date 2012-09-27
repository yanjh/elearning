#!/bin/bash
export RUBYOPT=rubygems
d=`dirname $0`
ruby $d/backend.rb &
ruby $d/listener.rb c0@yucai.im hello