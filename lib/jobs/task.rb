require 'base64'
require 'machinist'

module DPovray    
  class Task
    extend Machinist::Machinable                                    
    
    attr_accessor :project, :order, :partial_image, :povray_options
    
    @queue = :tasks 
    
    def self.queue
      @queue
    end
                                     
    def to_json(*a)
        {
          'json_class' => self.class.name,
          'data' => { 'project' => @project, 'order' => @order, 'partial_image' => @partial_image, 'povray_options'=> @povray_options }
        }.to_json(*a)
    end

    def self.json_create(o)
      new(project: o['data']['project'], order: o['data']['order'], partial_image: o['data']['partial_image'], povray_options: o['data']['povray_options'])
    end       
    
    def initialize(arguments={})
      @project = arguments[:project]
      @partial_image = arguments[:partial_image] || nil
      @povray_options = arguments[:povray_options]
      @order = arguments[:order]      
            
    end
    
    def <=>(o)      
      @order.to_i <=> o.order.to_i
    end   
    
    def ==(another_task)
      self.project == another_task.project and 
      self.order == another_task.order and 
      self.partial_image == another_task.partial_image and 
      self.povray_options == another_task.povray_options                        
    end
                
    def self.perform(task)                                                 
      task = JSON.parse(task)
      `mkdir -p /tmp/dpovray`
      tmp_directory = "/tmp/dpovray/"+ task.project.to_s + '/' + task.order + '/'
      scene_file = tmp_directory + 'scene.pov'                                   
      options = task.povray_options
      
      system("mkdir -p #{tmp_directory}")                    
      File.open(scene_file, "w") do |f|
          f.write(task.povray_options['scene'])
      end                                                         
      system("povray +O#{tmp_directory}image.tga +H#{options['height']} +W#{options['width']} +SR#{options['start_row']} +ER#{options['end_row']} +SC#{options['start_column']} +EC#{options['end_column']} +FT #{scene_file} 2>/dev/null")
      task.partial_image = File.read("#{tmp_directory}image.tga")                              
         
      redi = Redis.new        
      project = JSON.parse(redi.hget('active_projects', task.project))                                
      project.tasks[task.order] = task
      if project.completed?
        project.image = DPovray::Merger.merge_partial_images_from_tasks(project.tasks)          
      end                                                        
      redi.hset('active_projects', task.project, project.to_json)                        
      puts "Processed a Task!"
      `rm -rf #{tmp_directory}`
      task
    end
  end
end                         
