require 'CSV'
require 'colored'

desc "Import data from csv files"
task :import => [:environment] do

	def show_title_for(model_name='<unknown>')
	  puts '###'.yellow.bold + " db:seed - Seeding #{model_name}".yellow
	end

	show_title_for "Hosts"
	file = "db/hosts-2000.csv"
	Host.transaction do
	  CSV.foreach(file, :headers => true) do |row|
	    Host.where(:id => row[0].sub('host#','').to_i).first_or_create!(:name => row[1],
	                                                                    :address => row[2])
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

	show_title_for "Bookings"
	file = "db/bookings-2000.csv"
	Booking.transaction do
	  CSV.foreach(file, :headers => true) do |row|
	    booking = Booking.where(:id => row[0].sub('b#','').to_i).first_or_create!(:start_date => row[2],
	                                                                              :end_date => row[3],
	                                                                              :number_of_guests => row[4])
	    Room.find(row[1].sub('room#','').to_i).bookings << booking
	  end  
	end
end