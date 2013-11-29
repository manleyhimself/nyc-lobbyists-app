# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :action do
    purpose "MyString"
    lobbyist_id 1
    client_id 1
    agency_id 1
    admin false
    legislative false
    payment 1
  end
end
