class Room < ActiveRecord::Base
  belongs_to :host
  has_many :bookings
  
  attr_accessible :capacity
    
  validates :capacity, :numericality => true
    
  def guests_between(start_date, end_date)
    return self.bookings.overlapping(start_date, end_date)
               .collect   { |booking| booking.number_of_guests }
               .inject(0) { |sum, guests| sum + guests } if start_date <= end_date
    return 0
  end
  
  def available_between?(start_date, end_date, guests)
    return (self.capacity - self.guests_between(start_date, end_date)) >= guests.to_i if start_date <= end_date
    return false
  end
  
end
