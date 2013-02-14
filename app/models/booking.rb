class Booking < ActiveRecord::Base
  belongs_to :room
  attr_accessible :end_date, :number_of_guests, :start_date
end
