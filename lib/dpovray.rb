$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'splitter'
require 'jobs/task'
require 'jobs/project'
require 'merger'
require "redis"
require 'resque'
require 'resque/active_projects'
