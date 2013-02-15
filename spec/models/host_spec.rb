require 'spec_helper'

describe Host do
  let(:h) { h = build(:host) }
  context "attributes" do
    
    it "should have a name attribute of type string" do
      h.name.should be_an_instance_of(String)
    end
    
    it "should have an address attribute of type string" do
      h.name.should be_an_instance_of(String)
    end
    
  end
end
