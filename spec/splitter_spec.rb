require 'spec_helper'

describe DPovray::Splitter do                                             
  describe "Split a project" do         
    subject do
      DPovray::Splitter.split_project_in_many_tasks(project)
    end
             
    describe "every 10 lines" do 
      context "from a square image" do 
        let(:project) { {name:'Pov', id:1000, options:{height:50, width:50}, image:''} }                       
        its(:to_a) { should == square_tasks}
      end
      
      context "from a rectangular image, big width" do
        let(:project) { {name:'Pov', id:1000, options:{height:50, width:100}, image:''} }                       
        its(:to_a) { should == rectangular_tasks_big_width}
      end
      
      context "from a rectangular image, big height" do
        let(:project) { {name:'Pov', id:1000, options:{height:100, width:50}, image:''} }                       
        its(:to_a) { should == rectangular_tasks_big_height}
      end      
    end 
  end
end   

def square_tasks  
  tasks = [
        {project:1000, options:{height:50, width:50, start_row:1, start_column:0, end_row:10, end_column:50 }},
        {project:1000, options:{height:50, width:50, start_row:11, start_column:0, end_row:20, end_column:50 }},
        {project:1000, options:{height:50, width:50, start_row:21, start_column:0, end_row:30, end_column:50 }},
        {project:1000, options:{height:50, width:50, start_row:31, start_column:0, end_row:40, end_column:50 }},
        {project:1000, options:{height:50, width:50, start_row:41, start_column:0, end_row:50, end_column:50 }}
      ]          
end

def rectangular_tasks_big_width  
  tasks = [
        {project:1000, options:{height:50, width:100, start_row:1, start_column:0, end_row:10, end_column:100 }},
        {project:1000, options:{height:50, width:100, start_row:11, start_column:0, end_row:20, end_column:100 }},
        {project:1000, options:{height:50, width:100, start_row:21, start_column:0, end_row:30, end_column:100 }},
        {project:1000, options:{height:50, width:100, start_row:31, start_column:0, end_row:40, end_column:100 }},
        {project:1000, options:{height:50, width:100, start_row:41, start_column:0, end_row:50, end_column:100 }},        
     ]          
end

def rectangular_tasks_big_height
  tasks = [
        {project:1000, options:{height:100, width:50, start_row:1, start_column:0, end_row:10, end_column:50 }},
        {project:1000, options:{height:100, width:50, start_row:11, start_column:0, end_row:20, end_column:50 }},
        {project:1000, options:{height:100, width:50, start_row:21, start_column:0, end_row:30, end_column:50 }},
        {project:1000, options:{height:100, width:50, start_row:31, start_column:0, end_row:40, end_column:50 }},
        {project:1000, options:{height:100, width:50, start_row:41, start_column:0, end_row:50, end_column:50 }},       
        {project:1000, options:{height:100, width:50, start_row:51, start_column:0, end_row:60, end_column:50 }},
        {project:1000, options:{height:100, width:50, start_row:61, start_column:0, end_row:70, end_column:50 }},
        {project:1000, options:{height:100, width:50, start_row:71, start_column:0, end_row:80, end_column:50 }},
        {project:1000, options:{height:100, width:50, start_row:81, start_column:0, end_row:90, end_column:50 }},
        {project:1000, options:{height:100, width:50, start_row:91, start_column:0, end_row:100, end_column:50 }},
     ]          
end