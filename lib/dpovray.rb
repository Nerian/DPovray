$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'json'
require 'redis' 
require 'resque'

require 'resque/project'
require 'resque/splitter'
require 'resque/jobs/task'
require 'resque/jobs/merge'
require 'resque/merger'
require 'resque/routes'
require 'bundler/setup'
require 'resque-multi-step'
