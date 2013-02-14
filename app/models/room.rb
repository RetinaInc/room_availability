class Room < ActiveRecord::Base
  belongs_to :host
  has_many :bookings
  
  attr_accessible :capacity
end
