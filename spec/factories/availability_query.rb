# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :availability_query do
    start_date "2013-02-14"
    end_date "2013-02-14"
		guests 1
  end
end
