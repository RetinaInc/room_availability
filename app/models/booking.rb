class Booking < ActiveRecord::Base
  belongs_to :room
  attr_accessible :start_date, :end_date, :number_of_guests
  
  validates :number_of_guests, :numericality => true
  
  scope :overlapping, lambda { |from, to| where("start_date <= ? AND ? <= end_date", to, from) if from <= to } 
  
end
