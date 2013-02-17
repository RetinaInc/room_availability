class AvailabilityQuery
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :guests, :start_date, :end_date
     
  validates_presence_of :start_date, :end_date, :guests
  validates :guests, :numericality => { :only_integer => true, :greater_than_or_equal_to => 1 }
  
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

end