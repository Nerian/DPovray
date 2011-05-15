require 'rubygems'
require 'sinatra'
require 'resque'
require 'erb'          
               
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'job'

module DPovray
  class App < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/' do                                               
      Resque.enqueue(Project, params['scene'][:tempfile].read, params)            
      redirect :status
    end
    
    get '/status' do
      erb :status
    end
      
    
    get '/get_file' do
      
    end
    
    post '/failing' do 
      #Resque.enqueue(FailingJob, params)
      #redirect "/"
    end
  end
end
