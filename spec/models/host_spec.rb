require 'spec_helper'

describe Host do
  let(:h) { h = build(:host) }
  context "attributes: " do
    
    it "should have a name attribute of type string" do
      h.name.should be_an_instance_of(String)
    end
    
    it "should have an address attribute of type string" do
      h.name.should be_an_instance_of(String)
    end
    
  end
  
  context "methods: " do
     
    describe "available_rooms_between" do
      before :all do
        @date = Date.today
        @host = create(:host_with_rooms, available_rooms: 2)
      end
      
      after :all do
        @host.destroy
      end
      
      it "should return empty array if start_date is later than end_date" do
        @host.available_rooms_between(@date, @date - 1, 1).should be_empty
      end
      
      it "should return an array with the rooms details of own rooms available in a certain date range for a number of guests" do
        @host.rooms.each do |room|
          room.stub(:check_capacity?).and_return(true)
        end
        result = @host.available_rooms_between(@date, @date, 1)
        result.count.should == @host.rooms.count
        result.first.should == [@host.rooms.first.id, @host.rooms.first.guests_between(@date, @date)]        
      end
      
      it "should not return a room's details if that room is not available in a certain date range for a number of guests" do
        @host.rooms.first.stub(:check_capacity?).and_return(true)
        @host.rooms.second.stub(:check_capacity?).and_return(false)
        result = @host.available_rooms_between(@date, @date, 1)
        result.count.should == 1
        result.first.should == [@host.rooms.first.id, @host.rooms.first.guests_between(@date, @date)]
      end
      
      it "should return empty array if all the rooms are occupied in a certain date range" do
        @host.rooms.each do |room|
          room.stub(:check_capacity?).and_return(false)
        end
        @host.available_rooms_between(@date, @date, 1).should be_empty
      end
    end
    
  end
end
