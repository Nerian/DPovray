#!/usr/bin/env ruby
require 'logger'
require 'resque/server'
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib') 
require 'dpovray'

use Rack::ShowExceptions

# Set the AUTH env variable to your basic auth password to protect Resque.
#AUTH_PASSWORD = ENV['AUTH']
#if AUTH_PASSWORD
#  Resque::Server.use Rack::Auth::Basic do |username, password|
#    password == AUTH_PASSWORD
#  end
#end

run Rack::URLMap.new \
  "/dpovray" => Resque::Server.new
