class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :capacity
      t.references :host

      t.timestamps
    end
    add_index :rooms, :host_id
  end
end
