class Host < ActiveRecord::Base
  has_many :rooms, :dependent => :destroy
  
  attr_accessible :address, :name
  
  def available_rooms_between(start_date, end_date, guests)
    rooms_available = []
    if start_date <= end_date 
      self.rooms.each do |room|
        guests_booked = room.guests_between(start_date, end_date)
        if (room.capacity - guests_booked) >= guests.to_i
          rooms_available << [room.id, guests_booked]
        end
      end
    end
    return rooms_available
  end  
end