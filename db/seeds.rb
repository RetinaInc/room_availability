# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

require 'csv'
require 'colored'

def show_title_for(model_name='<unknown>')
  puts '###'.yellow.bold + " db:seed - Seeding #{model_name}".yellow
end

show_title_for "Hosts"
file = "db/hosts-2000.csv"
Host.transaction do
  CSV.foreach(file, :headers => true) do |row|
    Host.where(:id => row[0].sub('host#','').to_i).first_or_create!(:name => row[1], :address => row[2])
  end  
end

show_title_for "Rooms"
file = "db/rooms-2000.csv"
Room.transaction do
  CSV.foreach(file, :headers => true) do |row|
    room = Room.where(:id => row[0].sub('room#','').to_i).first_or_create!(:capacity => row[2])
    Host.find(row[1].sub('host#','').to_i).rooms << room
  end  
end