require 'spec_helper'

describe Resque::Project do    
  let(:params) { {name:'Gondar', scene:'blablabla', height:50, width:70 } }
  
  describe 'A Project should have' do    
    subject { Resque::Project.new(params) }                        
        
    its(:name) { should == params[:name] }
    its(:id) { should be }
    its(:image) { should == nil }
    its(:tasks) { should == {} }
    its(:povray_options) { should be }
    
    describe "#povray_options" do
      subject { Resque::Project.new(params).povray_options }                                       
            
      its(['height']) { should == params[:height] }
      its(['width']) { should == params[:width] }
      its(['scene']) { should == params[:scene] }
    end       
  end   
  
  describe "A project" do    
    context "is completed" do
      subject{ project = Resque::Project.make(:completed) }      
      its(:completed?){ should == true}        
    end                                                     
    
    context "not completed" do
      subject{ project = Resque::Project.make(:with_tasks) }      
      its(:completed?){ should == false}
    end           
  end
end