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
                  
      tasks, project = Splitter.split_project_in_many_tasks(project)          
      Redis.new.hset('active_projects', project[:id], project)
      tasks.each do |task|
        Resque.enqueue(Task, task)
      end                    
      redirect "/resque"
    end        
  end
end
