require 'base64'

module DPovray    
  module Task
    @queue = :tasks   
    
    # The json structure of a task is:
    #
    #task = {
    #  project:1000, 
    #  partial_image:nil, 
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
                
    def self.perform(task)   
      
      
      `mkdir /tmp/dpovray`
      tmp_directory = "/tmp/dpovray/"+ task[:project].to_s + '/'
      scene_file = tmp_directory + 'scene.pov'
      system("mkdir #{tmp_directory}")                    
      File.open(scene_file, "w") do |f|
          f.write(task[:options][:scene])
      end
      system("povray #{scene_file} +O#{tmp_directory}image.png")                                                                                                        
      task[:partial_image] = Base64.encode64(File.read("#{tmp_directory}image.png"))                              
      puts "Processed a Task!"
      task
    end
  end
  
  module PartialImage
    @queue = :partial_images
    
    def self.perform(completed_task)
      
    end
  end
  
  module FinishedProject
    @queue = :finished_project

    def self.perform(params)
      puts 'Project succefully completed.'
    end
  end
end                         
