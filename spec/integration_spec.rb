require 'spec_helper'

describe DPovray::App do
  before do
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
end   

