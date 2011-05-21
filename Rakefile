$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib') 
require 'dpovray'
require 'resque/tasks'

desc "Start DPovray using `rackup`"
task :start do 
  exec "rackup config.ru"
end
