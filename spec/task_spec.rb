require 'spec_helper'  

describe DPovray::Task do                                                                                                                            
  describe "A worker should" do
    context "be able to perform Task that contains the whole image" do
      let(:task){ DPovray::Task.make }              
      let(:active_project){ DPovray::Project.make(:with_tasks) }
      
      before :each do                                                     
        Redis.new.hset('active_projects', active_project.id, active_project.to_json)        
      end     
      
      it "and return the completed task" do                                                 
        completed_task = DPovray::Task.perform(task.to_json)
        completed_task.partial_image.should be
      end

      it "and add that completed task to the Project" do                                
        completed_task = DPovray::Task.perform(task.to_json)                                                          
        project = JSON.parse(redis.hget('active_projects', task.project))            
        project.tasks[completed_task.order].should == completed_task
      end
    end    
  end  
end