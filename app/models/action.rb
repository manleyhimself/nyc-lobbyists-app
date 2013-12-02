class Action < ActiveRecord::Base
  has_many :lobbyist_actions
  has_many :lobbyists, through: :lobbyist_actions
  has_many :agency_actions
  has_many :agencies, through: :agency_actions
  belongs_to :client

  # @action.agencies and @action.lobbyists work!
  # @lobbyist.agencies and @lobbyist.clients result in repeats, so uniq must be called
  # @agency.clients and @agency.lobbyists    "                                       "
  # @client.agencies and @client.lobbyists 

  # another problem is that since lobbyists share actions, it will be difficult to determine how we will assign payments


end
