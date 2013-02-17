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
    it { page.should have_selector("button[type='submit']") }
    
    it { should_not render_template(:table)  }
    
  end

  describe "GET 'search'" do
    before(:all) do
      @host = create(:host_with_rooms, available_rooms: 2)
      @expected = @host.rooms.collect { |room| [room.id, room.guests_between(Date.today, Date.today)] }
    end
      
    after :all do
      @host.destroy
    end
    
    context "JSON response" do
      before :each do
        get 'search', :format => :json, :start_date => Date.today, :end_date => Date.today, :guests => 1
      end
      
      it { should respond_with(:success) }
      it { should respond_with_content_type(/json/)}
      it { should assign_to(:available_rooms) }
            
      it "should return the correct JSON" do 
        body = JSON.parse(response.body)
        body.should == @expected
      end
    end
    
    context "HTML response" do
      before :each do
        get 'search', :format => :html, :start_date => Date.today, :end_date => Date.today, :guests => 1
      end
      
      it { should render_template(:index) }
      it { should render_template(:table)  }
      
      it { should assign_to(:available_rooms) }
      
      # Checking that the table has the correct header
      it { page.should have_selector("table#availability_datatable") }
      it { page.should have_selector("th#host_ref") }
      it { page.should have_selector("th#host_name") }
      it { page.should have_selector("th#host_address") }
      it { page.should have_selector("th#room_ref") }
      it { page.should have_selector("th#guests_booked") }
      it { page.should have_selector("th#availability") }
      
      # Checking that the table has two rows with the rooms available
      it { page.should have_selector("tbody tr", :count => 2) }
      
    end
    
  end
end
