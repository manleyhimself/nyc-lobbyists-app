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
  increment = (x == 100 ? 0 : 1)
  Action.create(client_id: (x/10.round+ increment), payment: rand(100..5000))
end

100.times do 
  Action.create(client_id: (rand(1..10)), payment: rand(100..5000))
end

200.times do |x|
  increment = (x == 200 ? 0 : 1)
  AgencyAction.create(agency_id: (x/20.round+ increment), action_id:(x+1))
end

200.times do |x|
  AgencyAction.create(agency_id: (rand(1..10)), action_id: (rand(1..200)))
end

200.times do |x|
  increment = (x == 200 ? 0 : 1)
  LobbyistAction.create(lobbyist_id: (x/20.round+ increment), action_id:(x+1))
end

200.times do |x|
  LobbyistAction.create(lobbyist_id: (rand(1..10)), action_id: (rand(1..200)))
end

# Lobbyist.create(name: "Manley", firm_id: 2)
# Client.create(name: "JOhnny Test")
# Action.create(client_id: 11 )
# LobbyistAction.create(lobbyist_id: 11, action_id: 401)
# AgencyAction.create(agency_id: 5, action_id: 401)



