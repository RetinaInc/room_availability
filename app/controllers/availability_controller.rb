class AvailabilityController < ApplicationController

  def index
  end
  
  def search
    @available_rooms = Host.all.collect { 
          |host| host.available_rooms_between(params[:start_date],
                                              params[:end_date],
                                              params[:guests])
          }.flatten
    respond_to do |format|
      format.html { render :index } 
      format.json { render :json => @available_rooms.to_json }
    end    
  end
end
