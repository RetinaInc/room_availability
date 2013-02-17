class RemoveBookedGuestsFromRooms < ActiveRecord::Migration
  def change
    remove_column :rooms, :booked_guests
  end
end
