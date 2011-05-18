require 'spec_helper'

describe DPovray::Project do
  describe 'Create a project' do
    let(:params) { {name:'Gondar', scene:'blablabla', height:50, width:70 } }
    describe '#name' do                
      it "should be set " do
        DPovray::Project.create(params)['name'].should == params[:name]
      end
    end
    describe '#scene' do                
      it "should be set " do
        DPovray::Project.create(params)['image'].should == nil
      end
    end
    describe '#id' do                
      it "should be set " do
        DPovray::Project.create(params)['id'].should be
      end
    end
    describe "#partial_images" do
      it "should be set" do
        DPovray::Project.create(params)['tasks'].should be
      end
    end
    describe '#options' do                
      it "should has height " do
        DPovray::Project.create(params)['options']['height'].should == params[:height]
      end
      
      it "should has width " do
        DPovray::Project.create(params)['options']['width'].should == params[:width]
      end
      
      it "should has an scene file" do
        DPovray::Project.create(params)['options']['scene'].should == params[:scene]
      end
    end        
  end
  
  describe "A project" do    
    context "is completed" do
      let(:project) { {'name'=>'Pov', 'tasks'=>{}, 'id'=>1000, 'options'=>{'height'=>50, 'width'=>100, 'scene'=>'blabla'}, 'image'=>nil} }
    end
    pending
  end
end