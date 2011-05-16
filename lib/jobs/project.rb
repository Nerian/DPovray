module DPovray
  module Project    
    def self.create(params)                                                                                                    
      project = 
      {
        name:params[:name], 
        id:rand(10000), 
        image:'',
        partial_images:[],
        options:
          {
            height:params[:height], 
            width:params[:width], 
            scene:params[:scene]
          }        
        }
    end

    def self.perform(scene, params)                  
      `mkdir /tmp/dpovray`
      tmp_directory = "/tmp/dpovray/"+ params["name"] + '/'
      scene_file = tmp_directory + params["scene"]["filename"]
      system("mkdir #{tmp_directory}")                    
      File.open(scene_file, "w") do |f|
          f.write(scene)
      end
      system("povray #{scene_file} +O#{tmp_directory}image.png")
      Resque.enqueue(FinishedProject, params["name"], Base64.encode64(File.read("#{tmp_directory}image.png")))     
      puts "Processed a job!"
    end
  end
end