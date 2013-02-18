require 'spec_helper'

describe AvailabilityQuery do
  let(:b) { b = build(:availability_query) }
  
  context "creation" do
    
    it "should be valid" do
      b.should be_valid
    end
    
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:guests) }
    it { should validate_numericality_of(:guests).only_integer }
    it { should validate_format_of(:start_date).with('2012-02-12') }
    it { should validate_format_of(:end_date).with('2012-02-12') }    
    
    [-1, -2, -3, 0].each do |negative|
      it "should not be valid if guests is less than #{negative}" do
        b.guests = negative
        b.should_not be_valid
      end
    end
    
    it "should not be valid if end date is before start date" do
      b.start_date.should <= b.end_date
      b.should be_valid
      temp = b.start_date
      b.start_date = b.end_date
      b.end_date = temp
      b.should_not be_valid
    end
    
    it "should not be valid if start date and/or end date are not in 'yyyy-mm-dd' format" do
      # TODO: use validate_timeliness removing all the formats but 'yyyy-mm-dd'
      ['01-01-2001', 'dasdas', '2001/01/02'].each do |invalid|
        b.end_date = invalid
        b.should_not be_valid
      end
    end
    
  end
end
