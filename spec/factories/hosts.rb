# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :host do
    name "MyString"
    address "MyString"
  end
  
  factory :host_with_available_rooms, :parent => :host do
    ignore do
      available_rooms 2
    end
    
    after(:create) do |host, evaluator|
      FactoryGirl.create_list(:room, evaluator.available_rooms, host: host)
    end
  end

end

