require 'spec_helper'

describe DPovray::Splitter do                                             
  describe "Split a project" do                       
    context "from a square image returns Tasks and Project" do       
      let(:project) { DPovray::Project.make(:square) } 
      
      describe "#Tasks" do
        subject { tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project); tasks }       
        
        it "should all be kind of DPovray:Task" do        
          subject.values.all?{|a| a.should be_a(DPovray::Task)}
        end
        
        [                          
          DPovray::Task.make(:project => 1000, :order=>'0', :povray_options=>{'height'=>50, 'width'=>50, 'start_row'=>1, 'start_column'=>1, 'end_row'=>10, 'end_column'=>50, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'1', :povray_options=>{'height'=>50, 'width'=>50, 'start_row'=>11, 'start_column'=>1, 'end_row'=>20, 'end_column'=>50, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'2', :povray_options=>{'height'=>50, 'width'=>50, 'start_row'=>21, 'start_column'=>1, 'end_row'=>30, 'end_column'=>50, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'3', :povray_options=>{'height'=>50, 'width'=>50, 'start_row'=>31, 'start_column'=>1, 'end_row'=>40, 'end_column'=>50, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'4', :povray_options=>{'height'=>50, 'width'=>50, 'start_row'=>41, 'start_column'=>1, 'end_row'=>50, 'end_column'=>50, 'scene'=> 'scene_file' }),
        ].each_with_index do |task, index|
            
          it "should have Task #{index} #{task.povray_options}" do            
            subject.values.should include(task)
          end
        end                    
      end                                     
      
      describe "#Project" do                                                                       
        subject { tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project); project2 }
        its('tasks.size') {should == 5}       
      end                               
    end

    context "from a rectangular image, big width" do
      let(:project) { DPovray::Project.make(:rectangular_big_width) }
                  
      describe "#Tasks" do
        subject { tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project); tasks }        
             
        it "should all be kind of DPovray:Task" do
          subject.values.all?{|a| a.should be_a(DPovray::Task)}
        end
        
        [                          
          DPovray::Task.make(:project => 1000, :order=>'0', :povray_options=>{'height'=>50, 'width'=>100, 'start_row'=>1, 'start_column'=>1, 'end_row'=>10, 'end_column'=>100, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'1', :povray_options=>{'height'=>50, 'width'=>100, 'start_row'=>11, 'start_column'=>1, 'end_row'=>20, 'end_column'=>100, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'2', :povray_options=>{'height'=>50, 'width'=>100, 'start_row'=>21, 'start_column'=>1, 'end_row'=>30, 'end_column'=>100, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'3', :povray_options=>{'height'=>50, 'width'=>100, 'start_row'=>31, 'start_column'=>1, 'end_row'=>40, 'end_column'=>100, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'4', :povray_options=>{'height'=>50, 'width'=>100, 'start_row'=>41, 'start_column'=>1, 'end_row'=>50, 'end_column'=>100, 'scene'=> 'scene_file' }),
        ].each_with_index do |task, index|
            
          it "should have Task #{index} #{task.povray_options}" do            
            subject.values.should include(task)
          end
        end
            
      end                                     
      
      describe "#Project" do                                                                       
        subject { tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project); project2 }
        its('tasks.size') {should == 5}       
      end              
    end

    context "from a rectangular image, big height" do
      let(:project) { DPovray::Project.make(:rectangular_big_height) }   
      
      describe "#Tasks" do
        subject { tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project); tasks }        
           
        it "should all be kind of DPovray:Task" do
          subject.values.all?{|a| a.should be_a(DPovray::Task)}
        end
        
        [                          
          DPovray::Task.make(:project => 1000, :order=>'0', :povray_options=>{'height'=>100, 'width'=>50, 'start_row'=>1, 'start_column'=>1, 'end_row'=>10, 'end_column'=>50, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'1', :povray_options=>{'height'=>100, 'width'=>50, 'start_row'=>11, 'start_column'=>1, 'end_row'=>20, 'end_column'=>50, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'2', :povray_options=>{'height'=>100, 'width'=>50, 'start_row'=>21, 'start_column'=>1, 'end_row'=>30, 'end_column'=>50, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'3', :povray_options=>{'height'=>100, 'width'=>50, 'start_row'=>31, 'start_column'=>1, 'end_row'=>40, 'end_column'=>50, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'4', :povray_options=>{'height'=>100, 'width'=>50, 'start_row'=>41, 'start_column'=>1, 'end_row'=>50, 'end_column'=>50, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'5', :povray_options=>{'height'=>100, 'width'=>50, 'start_row'=>51, 'start_column'=>1, 'end_row'=>60, 'end_column'=>50, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'6', :povray_options=>{'height'=>100, 'width'=>50, 'start_row'=>61, 'start_column'=>1, 'end_row'=>70, 'end_column'=>50, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'7', :povray_options=>{'height'=>100, 'width'=>50, 'start_row'=>71, 'start_column'=>1, 'end_row'=>80, 'end_column'=>50, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'8', :povray_options=>{'height'=>100, 'width'=>50, 'start_row'=>81, 'start_column'=>1, 'end_row'=>90, 'end_column'=>50, 'scene'=> 'scene_file' }),
          DPovray::Task.make(:project => 1000, :order=>'9', :povray_options=>{'height'=>100, 'width'=>50, 'start_row'=>91, 'start_column'=>1, 'end_row'=>100, 'end_column'=>50, 'scene'=> 'scene_file' }),
        ].each_with_index do |task, index|
            
          it "should have Task #{index} #{task.povray_options}" do            
            subject.values.should include(task)
          end
        end
            
      end                                     
      
      describe "#Project" do                                                                       
        subject { tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project); project2 }
        its('tasks.size') {should == 10}       
      end
    end      
  end
end   

