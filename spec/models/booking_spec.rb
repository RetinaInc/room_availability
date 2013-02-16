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
    
    it { should validate_numericality_of(:number_of_guests) }
        
    it { should belong_to(:room) }
 
  end
end
