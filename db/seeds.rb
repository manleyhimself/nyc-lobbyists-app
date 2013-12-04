# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


10.times do
  Client.create(:name => Faker::Name.name, address: '11 Broadway, New York, NY 10304')
end

10.times do
  Agency.create(:name => Faker::Name.name, description: 'this agency is critical')
end

5.times do
  Firm.create(:name => Faker::Name.name, address: '11 Broadway, New York, NY 10304')
end

10.times do |x| 
  Lobbyist.create(:name => Faker::Name.name, firm_id: (1))
end

10.times do |x| 
  Lobbyist.create(:name => Faker::Name.name, firm_id: (2))
end

10.times do |x| 
  Lobbyist.create(:name => Faker::Name.name, firm_id: (3))
end

10.times do |x| 
  Lobbyist.create(:name => Faker::Name.name, firm_id: (4))
end

10.times do |x| 
  Lobbyist.create(:name => Faker::Name.name, firm_id: (5))
end

150.times do |x|
  increment = (x == 150 ? 0 : 1)
  Action.create(client_id: (x/15.round+ increment), payment: rand(100..5000), purpose: 'administrative',begin_date: '2013-01-01', end_date: '2013-12-04')
end

100.times do 
  Action.create(client_id: (rand(1..10)), payment: rand(100..5000), purpose: 'legal',begin_date: '2013-01-01', end_date: '2013-12-04')
end

250.times do |x|
  increment = (x == 250 ? 0 : 1)
  AgencyAction.create(agency_id: (x/25.round+ increment), action_id:(x+3))
end

num = (1..10).to_a
10.times do |x|
  AgencyAction.create(agency_id: (num[x]), action_id: 1)
end

num = (1..10).to_a
10.times do |x|
  AgencyAction.create(agency_id: (num[x]), action_id: 2)
end


num = [1, 2, 3, 4, 5]
bum = (1..50).to_a
50.times do |x|
  LobbyistAction.create(lobbyist_id: (num[x % 5]), action_id:(bum[x]))
end

num = [11, 12, 13, 14, 15]
bum = (51..100).to_a
50.times do |x|
  LobbyistAction.create(lobbyist_id: (num[x % 5]), action_id:(bum[x]))
end

num = [21, 22, 23, 24, 25]
bum = (101..150).to_a
50.times do |x|
  LobbyistAction.create(lobbyist_id: (num[x % 5]), action_id:(bum[x]))
end

num = [31,32, 33, 34, 35]
bum = (151..200).to_a
50.times do |x|
  LobbyistAction.create(lobbyist_id: (num[x % 5]), action_id:(bum[x]))
end

num = [41, 42, 43, 44, 45]
bum = (201..250).to_a
50.times do |x|
  LobbyistAction.create(lobbyist_id: (num[x % 5]), action_id:(bum[x]))
end

num = [6, 7, 8, 9, 10]
bum = (1..50).to_a
50.times do |x|
  LobbyistAction.create(lobbyist_id: (num[x % 5]), action_id:(bum[x]))
end

num = [16, 17, 18, 19, 20]
bum = (51..100).to_a
50.times do |x|
  LobbyistAction.create(lobbyist_id: (num[x % 5]), action_id:(bum[x]))
end

num = [26, 27, 28, 29, 30]
bum = (101..150).to_a
50.times do |x|
  LobbyistAction.create(lobbyist_id: (num[x % 5]), action_id:(bum[x]))
end

num = [36, 37, 38, 39, 40]
bum = (151..200).to_a
50.times do |x|
  LobbyistAction.create(lobbyist_id: (num[x % 5]), action_id:(bum[x]))
end

num = [46, 47, 48, 49, 50]
bum = (201..250).to_a
50.times do |x|
  LobbyistAction.create(lobbyist_id: (num[x % 5]), action_id:(bum[x]))
end



