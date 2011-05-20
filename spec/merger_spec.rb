require 'spec_helper'

describe DPovray::Splitter do
  describe "Merge a project" do
    subject do
      tasks = {}
      partial_images.each_with_index do |image, index|
         tasks[index.to_s] = DPovray::Task.make(:order => index.to_s, :partial_image => image, :povray_options => {}) 
      end                                         
      DPovray::Merger.merge_partial_images_from_tasks(tasks)
    end                                                       
    
    it "should return an image" do
      subject.length.should > 10000
    end        
  end  
end                        

def partial_images()
  partial_images = []                  
  (0..9).to_a.each do |number|
    partial_images << File.read(File.dirname(__FILE__)+"/support/partial_images/image#{number}.tga") 
  end                                                                                               
  partial_images
end