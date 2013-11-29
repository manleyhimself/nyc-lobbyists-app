class Agency < ActiveRecord::Base
  has_many :actions
  has_many :lobbyists, through: :actions
  has_many :clients, through: :lobbyists
end
