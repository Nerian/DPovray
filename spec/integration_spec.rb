require 'spec_helper'

describe 'Dpovray' do                                       
  describe 'The user should be able to 'do      
    context "#add a new project" do
      it "should create tasks " do
        send_a_scene                                   
        Resque.queue(Resque::Task.queue).length.should == 10                
      end      
      
      it "Create active project" do
        send_a_scene                               
        redis.hlen('active_projects').should == 1
      end
    end
    
    describe "see the status of projects" do                                           
      context "not yet finished" do                                              
        before(:each) do
          send_a_scene
          visit('/project_statuses')
        end
        
        it "should show the name of projects" do
          page.should have_content('Gondar')        
        end                                  

        it "should show 'in progress' " do
          page.should have_content('In progress')
        end
      end
      
      context "finished" do
        before(:each) do
          send_a_scene          
          Resque.run! 
          visit('/project_statuses')
        end        
        
        it "should show the name of projects" do
          page.should have_content('Gondar')        
        end                                  

        it "should show the download link " do
          page.should have_content('Download Image')
        end
      end      
    end   
  end             
  
  describe "The workers should" do                                     
    context "#get jobs from the 'tasks' queue" do                        
      before (:each) do
        send_a_scene                 
        Resque.run!
      end
      
       it "should render" do                           
         Resque.queue(Resque::Task.queue).length.should == 0           
       end
       
       it "should save the partial images" do         
         projects = redis.hkeys('active_projects')         
         project = JSON.parse(redis.hget('active_projects', projects[0]))
         project.tasks.each_value do |task| 
           task.partial_image.should be
         end                           
       end
       
       it "should merge the image when the project is completed" do             
         projects = redis.hkeys('active_projects')         
         project = JSON.parse(redis.hget('active_projects', projects[0]))
         project.image.should be
       end              
    end                
  end
end                                                                             