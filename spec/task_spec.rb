require 'spec_helper'  

describe DPovray::Task do                                                                                                                            
  describe "A worker should" do
    context "be able to perform Task that contains the whole image" do
      let(:task){ {'project' => 1000, 'order' => "0", 'partial_image'=>nil, 'options' => {'height'=>50, 'width'=>50, 'start_row'=>1, 'start_column'=>1, 'end_row'=>50, 'end_column'=>50, 'scene'=>scene_file}} }
      
      before :each do                                          
        #list  = Redis::List.new('active_projects', redis)          
        #list[active_project[:id]] = active_project
        
        Redis.new.hset('active_projects', active_project['id'], JSON.dump(active_project))        
      end
      
      it "and return the completed task" do                                     
        completed_task = DPovray::Task.perform(task)
        completed_task['partial_image'].should be
      end

      it "and add that completed task to the Project" do
        completed_task = DPovray::Task.perform(task)                                                          
        project = JSON.parse(redis.hget('active_projects', task['project']))
        project["tasks"][completed_task['order']].should == completed_task
      end
    end
  end  
end 


def active_project
  data = {
    'name' => 'Pov', 
    'tasks' =>
      {
        "0" => 
        {
          'project' => 1000, 
          'order' => "0", 
          'partial_image' => nil, 
          'options' =>
            {
              'height' => 50, 
              'width' => 50, 
              'start_row' => 1,  
              'start_column' => 1, 
              'end_row' => 50, 
              'end_column' => 50, 
              'scene' => 'blabla' 
            }
          }
      }, 
    'id' => 1000, 
    'image' => '',
    'options' =>
      {
        'height' =>100,
        'width' => 50,
        'scene' => 'blabla'
      }
    }
end