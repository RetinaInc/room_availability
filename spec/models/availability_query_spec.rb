require 'spec_helper'

describe AvailabilityQuery do
  let(:b) { b = build(:availability_query) }
  
  context "creation" do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:guests) }
    it { should validate_numericality_of(:guests).only_integer }
    it { should validate_format_of(:start_date).with('2012-02-12') }
    it { should validate_format_of(:end_date).with('2012-02-12') }    
    
    it "should not be valid if guests is less than 1" do
      b.guests = 0
      b.should_not be_valid
    end
    
    it "should not be valid if end date is before start date" do
      temp = b.start_date
      b.start_date = b.end_date
      b.end_date = temp
      b.should_not be_valid
    end
    
    it "should not be valid if start date and/or end date are not in 'yyyy-mm-dd' format" do
      b.start_date = '01-01-2012'
      b.should_not be_valid
      b.end_date = 'fgsagfsdafsa'
      b.should_not be_valid
    end
    
  end
end
