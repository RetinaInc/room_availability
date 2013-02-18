require 'spec_helper'

describe "SearchAvailabilities" do
  
  let(:query) { build(:availability_query) }
  
  before :each do
    visit index_path
  end
  
  it "should show an error if form submission is invalid" do
    click_button 'Search'
    page.should have_content("Invalid search")
  end
  
  it "should show the availability table when clicking search (valid form submission)" do
    fill_in_query(query)
    page.should_not have_selector('table#availability_datatable')
    click_button "Search"
    page.should have_selector('table#availability_datatable')
  end
  
  it "should show only 5 hosts per page", :js => true do
    hosts = create_list(:host_with_rooms, 6)
    fill_in_query(query)
    click_button "Search"
    page.should have_selector('table#availability_datatable tbody tr', count: 5)
  end
    
end
