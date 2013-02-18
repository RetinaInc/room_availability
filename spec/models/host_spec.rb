require 'spec_helper'

describe Host do
  let(:h) { h = build(:host) }
  context "attributes: " do
    
    it { should be_valid }
    
    it "should have a name attribute of type string" do
      h.name.should be_an_instance_of(String)
    end
    
    it "should have an address attribute of type string" do
      h.name.should be_an_instance_of(String)
    end
    
    it { should have_many(:rooms) }
    
  end
  
  context "methods: " do
     
    describe "available_rooms_between two dates for a number of guests" do
      before :all do
        @date = Date.today
        @host = create(:host_with_rooms, available_rooms: 2)
      end
      
      after :all do
        @host.destroy
      end
      
      it "should return the rooms details (room_id, guests_booked) of all the rooms available" do
        @host.rooms.each do |room|
          room.stub(:check_capacity?).and_return(true)
        end
        available_rooms = @host.available_rooms_between(@date, @date, 1)
        available_rooms.count.should == @host.rooms.count
        available_rooms.first.should == [@host.rooms.first.id, @host.rooms.first.guests_between(@date, @date)]        
        available_rooms.second.should == [@host.rooms.second.id, @host.rooms.second.guests_between(@date, @date)]        
      end
      
      it "should return empty array if start_date is later than end_date" do
        @host.available_rooms_between(@date, @date - 1, 1).should be_empty
      end
      
      describe "if out of capacity" do
        it "should not return any room available" do
          @host.rooms.each do |room|
            room.stub(:check_capacity?).and_return(false)
          end
          @host.available_rooms_between(@date, @date, 1).should be_empty
        end
        
        it "should return only the room with capacity left (if any)" do
          @host.rooms.first.stub(:check_capacity?).and_return(true)
          @host.rooms.second.stub(:check_capacity?).and_return(false)
          result = @host.available_rooms_between(@date, @date, 1)
          result.count.should == 1
          result.first.should == [@host.rooms.first.id, @host.rooms.first.guests_between(@date, @date)]
        end
      end
      
    end
    
  end
end
