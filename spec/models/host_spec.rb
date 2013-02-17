require 'spec_helper'

describe Host do
  let(:h) { h = create(:host_with_rooms, available_rooms: 2) }
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
      it "should return empty array if start_date is later than end_date" do
        h.available_rooms_between(Date.today, Date.today-1, 1).should be_empty
      end
      
      it "should return an array with the rooms id of own rooms available in a certain date range for a number of guests" do
        h.rooms.each do |room|
          room.stub(:guests_between).and_return(0)
        end
        h.available_rooms_between(Date.today, Date.today, 1).count.should == h.rooms.count
      end
      
      it "should return an array with the rooms id of own rooms available in a certain date range for a number of guests" do
        h.rooms.first.stub(:guests_between).and_return(0)
        h.rooms.second.stub(:guests_between).and_return(h.rooms.second.capacity)
        h.available_rooms_between(Date.today, Date.today, 1).count.should == 1
      end
      
      it "should return empty array if all the rooms are occupied in a certain date range" do
        h.rooms.each do |room|
          room.stub(:guests_between).and_return(room.capacity)
        end
        h.available_rooms_between(Date.today, Date.today, 1).should be_empty
      end
    end
  end
end
