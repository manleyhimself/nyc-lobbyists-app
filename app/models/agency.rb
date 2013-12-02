class Agency < ActiveRecord::Base
  include ModelInstanceMethods
  has_many :agency_actions
  has_many :actions, through: :agency_actions
  has_many :lobbyists, through: :actions
  has_many :clients, through: :actions

end
