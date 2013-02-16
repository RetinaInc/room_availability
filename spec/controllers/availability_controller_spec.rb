require 'spec_helper'

describe AvailabilityController do

  # Render views and load the rendered content into Capybara for matching
  # See: http://stackoverflow.com/questions/4706370/rspec-view-testing-with-capybara-and-rails3/4773050#4773050#
  render_views
  let(:page) { Capybara::Node::Simple.new(@response.body) }
  
  describe "GET 'index'" do
    before { get :index }    

    it { should respond_with(:success) }
    it { should render_template(:index) }
 
    # Checking that all the necessary elements are present
    it { page.should have_selector("input#start_date") }
    it { page.should have_selector("input#end_date") }
    it { page.should have_selector("input#guests") }
    it { page.should have_selector("table#available_rooms") }
    it { page.should have_selector("button[type='submit']") }
    
    # Checking that the table has the correct header
    it { page.should have_selector("th#host_ref") }
    it { page.should have_selector("th#host_name") }
    it { page.should have_selector("th#host_address") }
    it { page.should have_selector("th#room_ref") }
    it { page.should have_selector("th#guests_booked") }
    it { page.should have_selector("th#availability") }

  end
 
end
