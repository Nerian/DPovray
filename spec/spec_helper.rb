require 'rspec'
require 'rack/test' 
require 'dpovray'
require 'resque_spec' 
require 'capybara'   
require 'capybara/rspec'
require 'redis/objects'         

include Capybara::DSL

Capybara.app = DPovray::App

set :environment, :test 

def app 
  Sinatra::Application
end     

RSpec.configure do |conf|
  conf.include Rack::Test::Methods    
  
  conf.before(:each) do    
    cleanup_redis    
  end
end

def redis
  Redis.new
end     

Redis::Objects.redis = Redis.new(:host => '127.0.0.1', :port => 6379)

def cleanup_redis
  redis.flushdb  
end
         
def send_a_scene
  visit('/') 
  page.fill_in('name', :with => 'Gondar')
  page.fill_in('height', :with => '100')
  page.fill_in('width', :with => '100')
  page.attach_file('scene', File.dirname(__FILE__) + "/support/buckyball.pov")
  page.click_button('submit')  
end 

def scene_file
  File.read(File.dirname(__FILE__)+"/support/buckyball.pov")
end