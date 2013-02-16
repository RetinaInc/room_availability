class Room < ActiveRecord::Base
  belongs_to :host
  has_many :bookings
  
  attr_accessible :capacity
  
  validates :capacity, :numericality => true
  
  #scope :with_availabilty_between, lambda { |start_date, end_date, guests| guests_between(start_date, end_date) <= capacity - guests }
  
  def guests_between(start_date, end_date)
    if start_date <= end_date 
      guests = 0
      self.bookings.overlapping(start_date, end_date).each do |booking|
        guests += booking.number_of_guests
      end
      return guests
    else
      return 0
    end
  end
    
end
