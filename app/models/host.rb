class Host < ActiveRecord::Base
  has_many :rooms, :dependent => :destroy
  
  attr_accessible :address, :name
  
  def available_rooms_between(start_date, end_date, guests)
    rooms_available = []
    self.rooms.each do |room|
      rooms_available << room.id if room.available_between?(start_date, end_date, guests)
    end
    return rooms_available
  end
end
