require 'spec_helper'

describe DPovray::Splitter do
  describe "Merge a project with many completed tasks" do
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
  
  describe "Merge a project with one completed task" do
    subject do
      tasks = { '0' => DPovray::Task.make(:order => '0', :partial_image => 'image', :povray_options => {})}
      DPovray::Merger.merge_partial_images_from_tasks(tasks)
    end                                                       
    
    it "should return an image" do
      subject.length.should == 5
    end        
  end
  
  describe "Merge a project with two completed tasks" do
    subject do
      tasks = 
      { 
        '0' => DPovray::Task.make(:order => '0', :partial_image => 'first image', :povray_options => {}),
        '1' => DPovray::Task.make(:order => '1', :partial_image => 'nineteen bits MagN here is the second image', :povray_options => {})
      }
      DPovray::Merger.merge_partial_images_from_tasks(tasks)
    end                                                       
    
    it "should return an image" do
      puts subject.inspect
      subject.should == 'first image here is the second image'
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