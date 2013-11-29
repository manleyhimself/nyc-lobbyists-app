class Client < ActiveRecord::Base
  has_many :actions
  has_many :lobbyists, through: :actions
  has_many :agencies, through: :actions
end
