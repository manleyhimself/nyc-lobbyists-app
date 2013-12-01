# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



10.times do
  Client.create(:name => Faker::Name.name)
end

10.times do
  Agency.create(:name => Faker::Name.name)
end

10.times do
  Firm.create(:name => Faker::Name.name)
end

10.times do |x| 
  Lobbyist.create(:name => Faker::Name.name, firm_id: (x+1))
end

100.times do |x|
  Action.create(client_id: (x+1), agency_id: (x+1), lobbyist_id: (x+1), payment: rand(100..5000))
end

100.times do 
  Action.create(client_id: (rand(1..10)), agency_id: (rand(1..10)), lobbyist_id: (rand(1..10)), payment: rand(100..5000))
end

