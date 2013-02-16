require 'spec_helper'

describe Room do
  let(:r) { r = build(:room) }
  context "attributes" do
    
    it { should validate_numericality_of(:capacity) }
    it { should belong_to(:host) }
        
  end
  
  context "methods" do
    before :all do 
      @room = create(:room)
    end
    after :all do
      @room.destroy
    end
    describe "guests_between" do
            
      it "should return 0 if start_date is later than end_date" do
        @room.guests_between(Date.new(2012,02,23), Date.new(2012,02,22)).should == 0
      end
      
      it "should return the number of guests staying in the room in a certain date range" do
        booking = create(:booking, :room => @room, :start_date => Date.new(2012,02,19), 
                         :end_date => Date.new(2012,02,23), :number_of_guests => 2)
        @room.bookings.overlapping(Date.new(2012,02,1), Date.new(2012,02,23)).count.should == 1
        @room.guests_between(Date.new(2012,02,1), Date.new(2012,02,23)).should == 2
        booking.destroy
      end
      
      it "should return 0 if there are no bookings in a certain date range" do
        booking = create(:booking, :room => @room, :start_date => Date.new(2012,02,24), 
                         :end_date => Date.new(2012,02,25), :number_of_guests => 2)
        @room.bookings.overlapping(Date.new(2012,02,1), Date.new(2012,02,23)).count.should == 0
        @room.guests_between(Date.new(2012,02,22), Date.new(2012,02,23)).should == 0
        booking.destroy
      end
    end
    
    describe "available_between?" do
      before :all do
        @start_date = Date.new(2012,02,19)
        @end_date = Date.new(2012,02,23)
      end
      
      it "should return 0 if start_date is later than end_date" do
        @room.available_between?(@end_date, @start_date, 1).should be_false
      end
      
      it "should return true if there is enough capacity for guests in a date range" do
        @room.stub(:guests_between).and_return(0)
        @room.available_between?(@start_date, @end_date, 1).should be_true
      end
      
      it "should return false if there is not enough capacity for guests in a date range" do
        @room.stub(:guests_between).and_return(@room.capacity)
        @room.available_between?(@start_date, @end_date, 1).should be_false
      end
    end
    
  end
    
end
