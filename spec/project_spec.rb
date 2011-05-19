require 'spec_helper'

describe DPovray::Project do    
  let(:params) { {name:'Gondar', scene:'blablabla', height:50, width:70 } }
  
  describe 'A Project should have' do    
    subject { DPovray::Project.new(params) }                        
        
    its(:name) { should == params[:name] }
    its(:id) { should be }
    its(:image) { should == nil }
    its(:tasks) { should == {} }
    its(:povray_options) { should be }
    
    describe "#povray_options" do
      subject { DPovray::Project.new(params).povray_options }      
                                 
      it "should pass povray_options as a hash" do
        pending()
      end
      
      its(['height']) { should == params[:height] }
      its(['width']) { should == params[:width] }
      its(['scene']) { should == params[:scene] }
    end       
  end   
  
  describe "A project" do    
    context "is completed" do      
    end
    pending
  end
end