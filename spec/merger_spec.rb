require 'spec_helper'

describe Resque::Merger do
  describe "Merge a project with many completed tasks" do
    subject do
      tasks = {}
      partial_images.each_with_index do |image, index|
         tasks[index.to_s] = image
      end                                         
      Resque::Merger.merge_partial_images_from_tasks(tasks)
    end                                                       
    
    it "should return an image" do
      subject.length.should > 10000
    end        
  end
  
  describe "Merge a project with one completed task" do
    subject do
      tasks = { '0' => 'image'}
      Resque::Merger.merge_partial_images_from_tasks(tasks)
    end                                                       
    
    it "should return an image" do
      subject.length.should == 5
    end        
  end
  
  describe "Merge a project with two completed tasks" do
    subject do
      tasks = 
      { 
        '0' => 'first image',
        '1' => 'nineteen bits MagN here is the second image'
      }
      Resque::Merger.merge_partial_images_from_tasks(tasks)
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