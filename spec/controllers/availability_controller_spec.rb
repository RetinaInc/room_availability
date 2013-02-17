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
    it { page.should have_selector("input#availability_query_start_date") }
    it { page.should have_selector("input#availability_query_end_date") }
    it { page.should have_selector("input#availability_query_guests") }
    it { page.should have_selector(".btn[type='submit']") }
    
    it { should_not render_template(:table)  }
    
  end

  describe "GET 'search'" do
    before(:all) do
      @date = Date.today
      @hosts = create_list(:host_with_rooms, 5, available_rooms: 2)
      # There are no bookings so all the rooms are available (guests_booked = 0)
      @expected = @hosts.collect{ |host| host.rooms.collect { |room| [room.id, 0] } } 
    end
      
    after :all do
      @hosts.each { |h| h.destroy } 
    end
    
    context "JSON response with no errors" do
      before :each do
        get 'search', :format => :json, :availability_query => { :start_date => @date, :end_date => @date, :guests => 1 }
      end
      
      it { should respond_with(:created) }
      it { should respond_with_content_type(/json/)}
      it { should assign_to(:available_rooms) }
            
      it "should return the correct JSON format" do 
        body = JSON.parse(response.body)
        body.should == @expected
      end
    end
    
    context "JSON response with errors" do
      before :all do
        @availability_query = AvailabilityQuery.new(:start_date => "", :end_date => "", :guests => "dsa")
        @expected = @availability_query.errors unless @availability_query.valid?
      end
      
      before {
        get 'search', :format => :json, :availability_query => { :start_date => "", :end_date => "", :guests => 'dasdas' }
      }
      
      it { should respond_with(:unprocessable_entity) }
      it { should_not assign_to(:available_rooms) }      
      it { should respond_with_content_type(/json/)}
      
      it "should return the errors in JSON format" do 
        response.body.should == @expected.to_json
      end
    end
    
    context "HTML response" do
      before :each do
        get 'search', :format => :html, :availability_query => { :start_date => @date, :end_date => @date, :guests => 1 }
      end
      
      it { should render_template(:index) }
      it { should render_template(:table)  }
      
      it { should assign_to(:available_rooms) }
      
      # Checking that the table has the correct header
      it { page.should have_selector("table#availability_datatable") }
      it { page.should have_selector("th#host_ref") }
      it { page.should have_selector("th#host_name") }
      it { page.should have_selector("th#host_address") }
      it { page.should have_selector("th#availability_details") }
      
      # Checking that the table has as many rows as the number of hosts
      it { page.should have_selector("tbody tr", :count => @hosts.length) }
      
    end
    
  end
end
