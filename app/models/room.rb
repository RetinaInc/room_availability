class Room < ActiveRecord::Base
  belongs_to :host
  has_many :bookings
  
  attr_accessible :capacity, :booked_guests
    
  validates :capacity, :numericality => true
    
  def guests_between(start_date, end_date)
    return self.bookings.overlapping(start_date, end_date)
               .collect   { |booking| booking.number_of_guests }
               .inject(0) { |sum, guests| sum + guests } if start_date <= end_date
    return 0
  end
  
  def check_capacity?(guests_booked, guests)
    return (self.capacity - guests_booked - guests) >= 0
  end
end
