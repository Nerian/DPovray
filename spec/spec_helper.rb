require 'rspec'
require 'rack/test' 
require 'dpovray'
require 'capybara'   
require 'capybara/rspec'   
include Capybara::DSL
require 'resque_spec'

Capybara.app = DPovray::App                  

set :environment, :test 

def app 
  Sinatra::Application
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end                         