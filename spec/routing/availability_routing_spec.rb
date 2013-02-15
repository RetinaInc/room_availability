require "spec_helper"

describe AvailabilityController do
  describe "routing" do

    it "routes to #search" do
      get("availability/search").should route_to("availability#search")
    end	

	end

end