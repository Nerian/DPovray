require 'resque/server'

module Resque                       
  module DPovray
    VIEW_PATH = File.join(File.dirname(__FILE__), 'server', 'views') 

    def self.registered(app)
      app.get '/new_project' do
        status_view(:new_project)
      end
      
      app.get '/project_statuses' do                                        
        projects = Resque.redis.hvals('active_projects')             
        @projects = []                               
        projects.each do |project|
          @projects << JSON.parse(project)
        end                                                           
        status_view(:status)
      end                                                     
      
      app.post '/new_project' do
        project = Project.new(
          :name => params["name"], 
          :height => params["height"].to_i, 
          :width => params["width"].to_i,
          :scene => params['scene'][:tempfile].read)

        tasks, project = Splitter.split_project_in_many_tasks(project)                
        Resque.redis.hset('active_projects', project.id, JSON.dump(project))
        
        Resque::Plugins::MultiStepTask.create(project.name) do |multistep|
          tasks.each_value do |task|
            multistep.add_job(Resque::Task, project.id, task.order)            
          end                                                      
          multistep.add_finalization_job Resque::Merge, project.id          
        end                
        redirect to('/')
      end

      app.get '/download/:id' do
        project = JSON.parse(Resque.redis.hget('active_projects', params[:id]))
        response.headers['content_type'] = "application/octet-stream"
        attachment(project.name+'.tga')
        response.write(project.image)
      end

      app.tabs << "New_Project" 
      app.tabs << "Project_statuses"

      app.helpers do
        def status_view(filename, options = {}, locals = {})
          erb(File.read(File.join(::Resque::DPovray::VIEW_PATH, "#{filename}.erb")), options, locals)
        end                
      end
    end                
  end  
end

Resque::Server.register Resque::DPovray