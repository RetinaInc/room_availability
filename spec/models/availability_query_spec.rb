require 'spec_helper'

describe AvailabilityQuery do
  let(:b) { b = build(:availability_query) }
  
  context "creation" do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:guests) }
    it { should validate_numericality_of(:guests).only_integer }
    
    it "should not be valid if guests is less than 1" do
      b.guests = 0
      b.should_not be_valid
    end
    
  end
end
