require 'spec_helper'

describe DPovray::Splitter do                                             
  describe "Split a project" do                      
    describe "every 10 lines" do 
      context "from a square image" do 
        let(:project) { {name:'Pov', tasks:[], id:1000, options:{height:50, width:50, scene:'blabla'}, image:''} }        
        it "should generate a list of tasks" do
          tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project) 
          tasks.should == square_tasks
        end
        
        it "should generate a project which contains the list of tasks" do
          tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project) 
          project2[:tasks].size.should == 5
        end        
      end
      
      context "from a rectangular image, big width" do
        let(:project) { {name:'Pov', tasks:[], id:1000, options:{height:50, width:100, scene:'blabla'}, image:''} }
        it "should generate a list of tasks" do
          tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project)
          tasks.should == rectangular_tasks_big_width
        end
        it "should generate a project which contains the list of tasks" do
          tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project) 
          project2[:tasks].size.should == 5
        end
      end
      
      context "from a rectangular image, big height" do
        let(:project) { {name:'Pov', tasks:[], id:1000, options:{height:100, width:50, scene:'blabla'}, image:''} }
        it "should generate a list of tasks" do
          tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project)
          tasks.should == rectangular_tasks_big_height
        end
        it "should generate a project which contains the list of tasks" do
          tasks, project2 = DPovray::Splitter.split_project_in_many_tasks(project) 
          project2[:tasks].size.should == 10
        end       
      end      
    end 
  end
end   

def square_tasks  
  tasks = [
        {project:1000, partial_image:nil, options:{height:50, width:50, start_row:1,  start_column:1, end_row:10, end_column:50, scene: 'blabla' }},
        {project:1000, partial_image:nil, options:{height:50, width:50, start_row:11, start_column:1, end_row:20, end_column:50, scene: 'blabla' }},
        {project:1000, partial_image:nil, options:{height:50, width:50, start_row:21, start_column:1, end_row:30, end_column:50, scene: 'blabla' }},
        {project:1000, partial_image:nil, options:{height:50, width:50, start_row:31, start_column:1, end_row:40, end_column:50, scene: 'blabla' }},
        {project:1000, partial_image:nil, options:{height:50, width:50, start_row:41, start_column:1, end_row:50, end_column:50, scene: 'blabla' }}
      ]          
end

def rectangular_tasks_big_width  
  tasks = [
        {project:1000, partial_image:nil, options:{height:50, width:100, start_row:1,  start_column:1, end_row:10, end_column:100, scene: 'blabla'  }},
        {project:1000, partial_image:nil, options:{height:50, width:100, start_row:11, start_column:1, end_row:20, end_column:100, scene: 'blabla'  }},
        {project:1000, partial_image:nil, options:{height:50, width:100, start_row:21, start_column:1, end_row:30, end_column:100, scene: 'blabla'  }},
        {project:1000, partial_image:nil, options:{height:50, width:100, start_row:31, start_column:1, end_row:40, end_column:100, scene: 'blabla'  }},
        {project:1000, partial_image:nil, options:{height:50, width:100, start_row:41, start_column:1, end_row:50, end_column:100, scene: 'blabla'  }},        
     ]          
end

def rectangular_tasks_big_height
  tasks = [
        {project:1000, partial_image:nil, options:{height:100, width:50, start_row:1,  start_column:1, end_row:10, end_column:50, scene: 'blabla'  }},
        {project:1000, partial_image:nil, options:{height:100, width:50, start_row:11, start_column:1, end_row:20, end_column:50, scene: 'blabla'  }},
        {project:1000, partial_image:nil, options:{height:100, width:50, start_row:21, start_column:1, end_row:30, end_column:50, scene: 'blabla'  }},
        {project:1000, partial_image:nil, options:{height:100, width:50, start_row:31, start_column:1, end_row:40, end_column:50, scene: 'blabla'  }},
        {project:1000, partial_image:nil, options:{height:100, width:50, start_row:41, start_column:1, end_row:50, end_column:50, scene: 'blabla'  }},       
        {project:1000, partial_image:nil, options:{height:100, width:50, start_row:51, start_column:1, end_row:60, end_column:50, scene: 'blabla'  }},
        {project:1000, partial_image:nil, options:{height:100, width:50, start_row:61, start_column:1, end_row:70, end_column:50, scene: 'blabla'  }},
        {project:1000, partial_image:nil, options:{height:100, width:50, start_row:71, start_column:1, end_row:80, end_column:50, scene: 'blabla'  }},
        {project:1000, partial_image:nil, options:{height:100, width:50, start_row:81, start_column:1, end_row:90, end_column:50, scene: 'blabla'  }},
        {project:1000, partial_image:nil, options:{height:100, width:50, start_row:91, start_column:1, end_row:100, end_column:50, scene: 'blabla'  }},
     ]          
end