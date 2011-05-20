module DPovray
  module Merger
    
    def self.merge_partial_images_from_tasks(tasks)
      puts 'Merging image'
      tasks = tasks.values.sort.reverse
      partial_images = []
      tasks.each do |task|
        partial_images << task.partial_image
      end
      partial_images_names = save_partial_images_to_tmp_folder(partial_images)
      
      (0..(partial_images_names.length()-2)).each do |i|
        image1, image2 = partial_images_names[i], partial_images_names[i+1]         
        puts "\ttail -c +19 #{image1} >> #{image2}"        
        `tail -c +19 #{image1} >> #{image2}`        
      end
      puts 'Image merged'
      final_image = File.read(partial_images_names.last)                                                                               
    end
    
       
    private 
    def self.save_partial_images_to_tmp_folder(partial_images)
      files = []                    
      tmp_folder = '/tmp/dpovray/merger'+ rand(10000).to_s + '/'
      system("mkdir -p #{tmp_folder}")
      partial_images.each_with_index do |image, index|
        files << tmp_folder+'image'+index.to_s+'.tga'
        File.open(tmp_folder+'image'+index.to_s+'.tga', "w") do |f|
            f.write(image)
        end                               
      end                        
      files
    end
  end
end