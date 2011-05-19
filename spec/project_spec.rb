require 'spec_helper'

describe DPovray::Project do
  describe 'Create a project' do
    let(:params) { {name:'Gondar', scene:'blablabla', height:50, width:70 } }
    subject { DPovray::Project.new(params) }                        
        
    its(:name) { should == params[:name] }
    its(:id) { should be }
    its(:image) { should == nil }
    its(:tasks) { should == {} }
    its(:povray_options) { should be }
    
    describe "#povray_options" do
      subject { DPovray::Project.new(params).povray_options }      
      
      its(['height']) { should == params[:height] }
      its(['width']) { should == params[:width] }
      its(['scene']) { should == params[:scene] }
    end       
  end
  
  describe "A project" do    
    context "is completed" do
      let(:project) { {'name'=>'Pov', 'tasks'=>{}, 'id'=>1000, 'povray_options'=>{'height'=>50, 'width'=>100, 'scene'=>'blabla'}, 'image'=>nil} }
    end
    pending
  end
end