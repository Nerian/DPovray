require 'rspec'
require 'rack/test' 
require 'dpovray' 
require 'capybara'   
require 'capybara/rspec'
require 'resque'
require 'resque/server'
require 'resque_unit'
require 'machinist'
require 'support/blueprints'
         
include Capybara::DSL            

Capybara.app = Resque::Server.new

#set :environment, :test 

def app 
  Sinatra::Application
end     

RSpec.configure do |conf|
  conf.include Rack::Test::Methods    
  
  conf.before(:each) do    
    cleanup_redis    
    Resque.reset!
  end
end

def redis
   Redis.new
end     

def cleanup_redis
  redis.flushdb  
end
         
def send_a_scene
  visit('/new_project') 
  page.fill_in('name', :with => 'Gondar')
  page.fill_in('height', :with => '100')
  page.fill_in('width', :with => '100')
  page.attach_file('scene', File.dirname(__FILE__) + "/support/buckyball.pov")
  page.click_button('submit')  
end 

def scene_file
  File.read(File.dirname(__FILE__)+"/support/buckyball.pov")
end             

