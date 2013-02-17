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
        format.json { render :json => @available_rooms.to_json, status: :created }
      else
        format.html { render :index }
        format.json { render json: @availability_query.errors, status: :unprocessable_entity }
      end
    end
  end

private 

  def get_available_rooms(query)
    Host.all.collect { 
      |host| host.available_rooms_between(query.start_date, query.end_date, query.guests.to_i)
    }
  end

end