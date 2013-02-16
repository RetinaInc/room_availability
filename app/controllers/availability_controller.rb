class AvailabilityController < ApplicationController

  def index
  end
  
  def search
    respond_to do |format| 
      format.json { 
        render :json => Host.all.collect { 
          |host| host.available_rooms_between(params[:start_date],
                                              params[:end_date],
                                              params[:guests])
          }.flatten
      }
    end    
  end
end
