require 'spec_helper'

describe Booking do
  let(:b) { b = build_stubbed(:booking) }
  context "attributes" do
    
    it "should have a start_date attribute of type Date" do
      b.start_date.should be_an_instance_of(Date)
    end
    
    it "should have an end_date attribute of type Date" do
      b.end_date.should be_an_instance_of(Date)
    end
    
    it "should have a number_of_guests attribute of type Fixnum" do
      b.number_of_guests.should be_an_instance_of(Fixnum)
    end
    
    it "should have a room associated" do
      b.room.should be_an_instance_of(Room)
    end
        
  end
end
