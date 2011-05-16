require 'spec_helper'

describe DPovray::App do
  before do
    ResqueSpec.reset!
  end
  
  describe 'The user should be able to 'do      
    it "add a new project" do
      send_a_scene                    
      DPovray::Task.should have_queue_size_of(10)     
    end                       
  end  
end   

def send_a_scene
  visit('/') 
  page.fill_in('name', :with => 'Gondar')
  page.fill_in('height', :with => '100')
  page.fill_in('width', :with => '100')
  page.attach_file('scene', File.dirname(__FILE__) + "/support/buckyball.pov")
  page.click_button('submit')  
end