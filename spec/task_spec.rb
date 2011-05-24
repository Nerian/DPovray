require 'spec_helper'  

describe Resque::Task do                                                                                                                            
  describe "A worker should" do
    context "be able to perform Task that contains the whole image" do
      let(:task){ Resque::Task.make }              
      let(:active_project){ Resque::Project.make(:with_tasks) }
      
      before :each do                                                     
        Redis.new.hset('active_projects', active_project.id, active_project.to_json)        
      end     
      
      it "and return the completed task" do                                                 
        completed_task = Resque::Task.perform(active_project.id, task.order)
        completed_task.partial_image.should be
      end

      it "and add that completed task to the partial images list" do                                
        completed_task = Resque::Task.perform(active_project.id, task.order)                                                                  
        partial_image = redis.hget('resque:dpovray:images-for-project:'+active_project.id.to_s, completed_task.order)
        partial_image.should == completed_task.partial_image                              
      end
    end    
  end  
end