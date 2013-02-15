require 'spec_helper'

describe Room do
  let(:r) { r = build_stubbed(:room) }
  context "attributes" do
    
    it "should have a capacity attribute of type Fixnum" do
      r.capacity.should be_an_instance_of(Fixnum)
    end
    
    it "should have a host associated" do
      r.host.should be_an_instance_of(Host)
    end
        
  end
    
end
