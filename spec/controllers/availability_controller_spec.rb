require 'spec_helper'

describe AvailabilityController do

  # Render views and load the rendered content into Capybara for matching
  # See: http://stackoverflow.com/questions/4706370/rspec-view-testing-with-capybara-and-rails3/4773050#4773050#
  render_views
  let(:page) { Capybara::Node::Simple.new(@response.body) }

  describe "GET 'search'" do
    before { get :search }    

    it { should respond_with(:success) }
    it { should render_template(:search) }
 
    # Test the rendered view using Capybara matchers
    it { page.should have_selector("input#start_date") }
    it { page.should have_selector("input#end_date") }
    it { page.should have_selector("input#guests") }
    it { page.should have_selector("table#available_rooms") }
  end
end
