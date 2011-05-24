require 'spec_helper'

describe "Merger" do                                                          
  
  it "TAIL MERGER" do
    partial_image = JSON.parse(File.read(File.dirname(__FILE__)+"/support/code"))
    image = Resque::Merger.merge_partial_images_from_tasks(partial_image)
    
    File.open("/tmp/image-tail-merger.tga", "w") do |f|
        f.write(image)
    end
  end
  
  it "IN MEMORY MERGER" do                                    
    partial_image = JSON.parse(File.read(File.dirname(__FILE__)+"/support/code"))
    image = Resque::InMemoryMerger.merge_partial_images_from_tasks(partial_image)
    
    File.open("/tmp/image-"+Time.at(Time.now).usec.to_s+'.tga', "w") do |f|
        f.write(image)
    end                                                                                                             
  end
end