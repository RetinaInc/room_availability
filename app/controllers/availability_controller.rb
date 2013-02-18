class AvailabilityController < ApplicationController

  def index
    @availability_query = AvailabilityQuery.new
  end
  
  def search
    @availability_query = AvailabilityQuery.new(params[:availability_query])
    respond_to do |format|
      if @availability_query.valid?
        @available_rooms = get_available_rooms(@availability_query)
        format.html { render :index } 
        format.json { render :json => @available_rooms, status: :created }
      else
        @available_rooms = []
        format.html { render :index }
        format.json { render json: @availability_query.errors, status: :unprocessable_entity }
      end
    end
  end

private 

  def get_available_rooms(query)    
    result = []
    Host.all.each do |host|
      rooms = host.available_rooms_between(query.start_date, query.end_date, query.guests.to_i)
      result << { host: host.id, rooms: rooms } if rooms.present?
    end
    return result
  end

end