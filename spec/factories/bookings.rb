# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    number_of_guests 1
    room nil
    start_date "2013-02-14"
    end_date "2013-02-14"
  end
end
