require 'spec_helper'

describe DPovray::Splitter do                                             
  describe "Split a project" do                      
    describe "every 10 lines" do 
      context "from a square image" do 
        let(:project) { {'name'=>'Pov', 'tasks'=>{}, 'id'=> 1000, 'povray_options'=> {'height'=>50, 'width'=>50, 'scene'=>'blabla'}, 'image'=>nil} }        
        it "should generate a list of tasks" do
          tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project) 
          tasks.each_value do |task|
            task.should be_a(DPovray::Task)
          end 
        end      
        
        it "should generate a list of tasks" do
          pending()
          tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project) 
          tasks.each do |task|
            task.should be_a(DPovray::Task)
          end
        end 
        
        it "should generate a project which contains the list of tasks" do
          tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project) 
          project2['tasks'].size.should == 5
        end        
      end
      
      context "from a rectangular image, big width" do
        let(:project) { {'name'=>'Pov', 'tasks'=>{}, 'id'=>1000, 'povray_options'=>{'height'=>50, 'width'=>100, 'scene'=>'blabla'}, 'image'=>nil} }
        it "should generate a list of tasks" do
          tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project)
          tasks.each_value do |task|
            task.should be_a(DPovray::Task)
          end
        end
        it "should generate a project which contains the list of tasks" do
          tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project) 
          project2['tasks'].size.should == 5
        end
      end
      
      context "from a rectangular image, big height" do
        let(:project) { {'name'=>'Pov', 'tasks'=>{}, 'id'=>1000, 'povray_options'=>{'height'=>100, 'width'=>50, 'scene'=>'blabla'}, 'image'=>nil} }
        it "should generate a list of tasks" do
          tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project)
          tasks.each_value do |task|
            task.should be_a(DPovray::Task)
          end
        end
        it "should generate a project which contains the list of tasks" do
          tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project) 
          project2['tasks'].size.should == 10
        end       
      end      
    end 
  end
end   

