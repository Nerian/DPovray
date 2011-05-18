require 'base64'

module DPovray    
  class Task
    @queue = :tasks
    
    attr_accessor :project, :order, :partial_image, :options
    
    def self.queue
      @queue      
    end
    
    def to_json(*a)
        {
          'json_class' => self.class.name,
          'data' => { 'project' => @project, 'order' => @order, 'partial_image' => @partial_image, 'options'=> @options }
        }.to_json(*a)
      end

      def self.json_create(o)
        new(project: o['data']['project'], order: o['data']['order'], partial_image: o['data']['partial_image'], options: o['data']['options'])
      end
    
    def initialize(arguments)
      @project = arguments[:project]
      @partial_image = arguments[:partial_image]
      @order = arguments[:order]      
      @options = arguments[:options]      
    end   
    
    # The json structure of a task is:
    #
    #task = {
    #  project:1000, 
    #  partial_image:nil,
    #  order:'1' 
    #  options:
    #    {
    #      height:50, 
    #      width:50, 
    #      start_row:1,  
    #      start_column:1, 
    #      end_row:10, 
    #      end_column:50, 
    #      scene: 'blabla' 
    #      }
    #    }  
    
    def ==(another_task)
      self.project == another_task.project and 
      self.order == another_task.order and 
      self.partial_image == another_task.partial_image and 
      self.options == another_task.options                        
    end
                
    def self.perform(task)                                                 
      task = JSON.parse(task)
      `mkdir -p /tmp/dpovray`
      tmp_directory = "/tmp/dpovray/"+ task.project.to_s + '/' + task.order + '/'
      scene_file = tmp_directory + 'scene.pov'
      system("mkdir -p #{tmp_directory}")                    
      File.open(scene_file, "w") do |f|
          f.write(task.options['scene'])
      end
      system("povray #{scene_file} +O#{tmp_directory}image.png 2>/dev/null")                                                                                                        
      task.partial_image = Base64.encode64(File.read("#{tmp_directory}image.png"))                
                              
      redis.multi do                                             
        project = JSON.parse(redis.hget('active_projects', task.project))                 
        project["tasks"][task.order] = task
        redis.hset('active_projects', task.project, JSON.dump(project))        
      end                             
      puts "Processed a Task!"
      task
    end
  end
end                         
