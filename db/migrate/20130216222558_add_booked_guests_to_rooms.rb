class AddBookedGuestsToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :booked_guests, :integer
  end
end
