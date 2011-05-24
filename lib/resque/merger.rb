module Resque  
  module InMemoryMerger
    def self.merge_partial_images_from_tasks(image_hash)
      puts 'Merging image'                          
                 
      top_partial = image_hash['0']
      image_hash.delete('0')                  
      
      image_hash.each { |k,v| v.slice!(1,18) }                      
      final_image = [top_partial, (image_hash.keys.sort).collect{ |i| image_hash[i] }.join].join
            
      puts 'Image merged'
      final_image                                                                                
    end               
  end

  module Merger    
    def self.merge_partial_images_from_tasks(hash_OrderImage)
      puts 'Merging image'                               
      partial_images_names = save_partial_images_to_tmp_folder(hash_OrderImage) 

      puts partial_images_names.inspect

      partial_images_names.each_cons 2 do |origin, destiny|
        puts "\ttail -c +19 #{origin} >> #{destiny}"        
        `tail -c +19 #{origin} >> #{destiny}`
      end            
      puts 'Image merged'
      final_image = File.read(partial_images_names.last)                                                                               
    end


    private 
    def self.save_partial_images_to_tmp_folder(partial_images)             
      files = []                    
      tmp_folder = '/tmp/dpovray/merger'+ rand(10000).to_s + '/'
      system("mkdir -p #{tmp_folder}")

      keys = partial_images.keys.sort{|a,b| a.to_i <=> b.to_i}.reverse

      puts 'Keys: '+keys.inspect

      keys.each do |key|
        image = partial_images[key.to_s]                                     
        files << tmp_folder+'image'+key.to_s+'.tga'
        File.open(tmp_folder+'image'+key.to_s+'.tga', "w") do |f|
          f.write(image)
        end
      end                                  
      files
    end
  end
end