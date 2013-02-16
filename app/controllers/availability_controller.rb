class AvailabilityController < ApplicationController

  def index
  end
  
  def search
    respond_to do |format| 
      format.json { render :json => nil }
    end    
  end
end
