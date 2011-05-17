require 'spec_helper'

describe DPovray::App do
  before :each do
    ResqueSpec.reset!                     
  end                                     
  
  describe 'The user should be able to 'do      
    context "#add a new project" do
      it "should create tasks " do
        send_a_scene
        DPovray::Task.should have_queue_size_of(10)     
      end 
      
      it "Create active project" do
        send_a_scene                               
        redis.hlen('active_projects').should == 1
      end
    end   
  end             
  
  describe "The workers should" do                                 
    before :each do
    end
    
    context "#get jobs from the 'tasks' queue" do                        
       it "should render" do         
         with_resque do
           send_a_scene
           DPovray::Task.should have_queue_size_of(0)
           redis.hgetall('active_projects')
         end
       end
    end    
  end
end   

