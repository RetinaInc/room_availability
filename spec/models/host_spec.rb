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
  
  context "methods" do
    describe "available_rooms_between" do
      it "should return an array with the rooms id of own rooms available in a certain date range for a number of guests" do
        Room.stub(:available_between?).and_return(true)
        h.available_rooms_between(Date.today, Date.today, 1).count.should == h.rooms.count
      end
      
      it "should return empty array if all the rooms are occupied in a certain date range" do
        Room.stub(:available_between?).and_return(false)
        h.available_rooms_between(Date.today, Date.today, 1).should be_empty
      end
    end
  end
end
