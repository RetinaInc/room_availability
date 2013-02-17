class AvailabilityQuery
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :guests, :start_date, :end_date
       
  validates :start_date, :end_date, :presence => true, :format => { :with => /^(19|20)\d\d-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/ }
  validates :guests, :presence => true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 1 }
  
  validate :validate_end_date_after_start_date
  
  class << self
    def all
      return []
    end
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
  
  def validate_end_date_after_start_date
    if start_date && end_date
      errors.add(:start_date, "must fall before end date") if end_date < start_date
    end
  end

end