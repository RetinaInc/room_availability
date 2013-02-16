require "spec_helper"

describe AvailabilityController do
  describe "routing" do

    it "routes to #index" do
      get("availability/index").should route_to("availability#index")
    end	

    it "routes to #search" do
      post("availability/search").should route_to("availability#search")
    end	

	end

end