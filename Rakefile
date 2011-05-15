$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib') 
require 'dpovray'
require 'resque/tasks'

desc "Start the demo using `rackup`"
task :start do 
  exec "rackup config.ru"
end
