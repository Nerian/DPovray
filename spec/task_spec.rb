require 'spec_helper'

describe DPovray::Task do
  before do
    ResqueSpec.reset!
  end                                                                                                                                       
  describe "A worker should" do
    context "be able to perform Task that contains the whole image" do
      let(:task){ {project:1000, order: 0, partial_image:nil, options:{height:50, width:50, start_row:1, start_column:1, end_row:50, end_column:50, scene:scene_file}} }
      let(:project){ active_project }
      
      before :each do          
        Redis.new.hset('active_projects', project[:id], project)        
      end
      
      it "and return the completed task" do                                     
        completed_task = DPovray::Task.perform(task)
        completed_task[:partial_image].should be
      end

      it "and add that completed task to the Project" do
        completed_task = DPovray::Task.perform(task)                                                          
        project = redis.hget('active_projects', task[:project])
        project[:partial_images].should include(completed_task)
      end
    end
  end  
end 


def active_project
  {
    name:'Pov', 
    tasks:
      {
        0 => 
        {
          project:1000, 
          order: 0, 
          partial_image:nil, 
          options:
            {
              height:50, 
              width:50, 
              start_row:1,  
              start_column:1, 
              end_row:50, 
              end_column:50, 
              scene: 'blabla' 
            }
          }
      }, 
    id:1000, 
    image:'',
    options:
      {
        height:100,
        width:50,
        scene:'blabla'
      }
    }
end