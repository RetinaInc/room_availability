require 'spec_helper'

describe AvailabilityQuery do
  let(:b) { b = build(:availability_query) }
    
  context "creation" do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_format_of(:start_date).with('2012-01-02') }
    it { should validate_format_of(:end_date).with('2012-01-02') }
    it { should validate_presence_of(:guests) }
    it { should validate_numericality_of(:guests).only_integer }
  end
end
