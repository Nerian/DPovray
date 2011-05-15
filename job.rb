require 'resque'
require 'base64'
require 'date'

module DPovray
  module Project
    @queue = :render_project

    def self.perform(scene, name, params)
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
  
  module FinishedProject
    @queue = :finished_project

    def self.perform(params)
      puts 'Project succefully completed.'
    end
  end
end                         
