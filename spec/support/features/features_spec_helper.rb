module FeaturesSpecHelper

  def fill_in_query(query)
    fill_in "Start date", with: query.start_date
    fill_in "End date", with: query.end_date
    fill_in "Guests", with: query.guests
  end
end
