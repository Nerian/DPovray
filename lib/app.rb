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
                                                           
      project = Project.new(
        :name => params["name"], 
        :height => params["height"].to_i, 
        :width => params["width"].to_i,
        :scene => params['scene'][:tempfile].read)
                  
      tasks, project = Splitter.split_project_in_many_tasks(project)                
      Redis.new.hset('active_projects', project.id, JSON.dump(project))
      tasks.each_value do |task|
        Resque.enqueue(DPovray::Task, JSON.dump(task))
      end                    
      redirect "/resque"
    end        
  end
end
