require 'spec_helper'

describe DPovray::Splitter do                                             
  describe "Split a project" do         
    subject do
      DPovray::Splitter.split(project)
    end
             
    describe "#value" do 
      context "a square image" do 
        let(:project) { {name:'Pov', id:1000, options:{height:400, width:400}, image:''} }
        its(:value) { should == 
          [ 
            {project:1000, options:{height:400, width:400, start_row:0, start_column:0, end_row:200, end_column:400 }},
            {project:1000, options:{height:400, width:400, start_row:200, start_column:0, end_row:400, end_column:400 }}
          ] 
        }
      end      
    end 
  end
end