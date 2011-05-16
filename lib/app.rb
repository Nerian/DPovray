require 'rubygems'
require 'sinatra'
require 'resque'
require 'erb'                       

module DPovray
  class App < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/' do                                               
      project = Project.create(
        :name => params["name"], 
        :height => params["height"].to_i, 
        :width => params["width"].to_i,
        :scene => params['scene'][:tempfile].read)
      
      Splitter.split_project_in_many_tasks(project).each do |task|  
        Resque.enqueue(Task, task)        
      end
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
