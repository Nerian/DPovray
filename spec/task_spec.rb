require 'spec_helper'  

describe DPovray::Task do                                                                                                                            
  describe "A worker should" do
    context "be able to perform Task that contains the whole image" do
      let(:task){ DPovray::Task.make }
      
      
      before :each do                                                  
        Redis.new.hset('active_projects', active_project['id'], JSON.dump(active_project))        
      end
      
      it "the blue print and project should have the same id." do
        pending()
      end
      
      it "and return the completed task" do                                     
        completed_task = DPovray::Task.perform(task.to_json)
        completed_task.partial_image.should be
      end

      it "and add that completed task to the Project" do
        completed_task = DPovray::Task.perform(task.to_json)                                                          
        project = JSON.parse(redis.hget('active_projects', task.project))
        project["tasks"][completed_task.order].should == completed_task
      end
    end    
  end  
end 


def active_project
  data = {
    'name' => 'Pov', 
    'tasks' =>
      {
        "0" => DPovray::Task.make
      }, 
    'id' => 1000, 
    'image' => '',
    'povray_options' =>
      {
        'height' =>100,
        'width' => 50,
        'scene' => scene_file
      }
    }
end