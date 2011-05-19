module DPovray
  class Project
    
    attr_reader :name, :id, :image, :tasks, :povray_options
    
    def initialize(params)
      @name = params[:name]
      @id = rand(10000)
      @image = nil
      @tasks = {}
      @povray_options = { 'height' => params[:height], 'width' => params[:width], 'scene' => params[:scene] }
    end        
        
    def self.create(params)                                                                                                    
      project = 
      {
        'name'=> params[:name], 
        'id'=> rand(10000), 
        'image' => nil,
        'tasks' => {},
        'povray_options' =>
          {
            'height' => params[:height], 
            'width' => params[:width], 
            'scene' => params[:scene]
          }        
        }
    end

    def self.perform(scene, params)                  
     # `mkdir /tmp/dpovray`
     # tmp_directory = "/tmp/dpovray/"+ params["name"] + '/'
     # scene_file = tmp_directory + params["scene"]["filename"]
     # system("mkdir #{tmp_directory}")                    
     # File.open(scene_file, "w") do |f|
     #     f.write(scene)
     # end
     # system("povray #{scene_file} +O#{tmp_directory}image.png")
     # Resque.enqueue(FinishedProject, params["name"], Base64.encode64(File.read("#{tmp_directory}image.png")))     
     # puts "Processed a job!"
    end
  end

  def self.completed?(project)    
    project['tasks'].all? { |task| task['partial_image'] }  
  end
  
end