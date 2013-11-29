class Action < ActiveRecord::Base
  belongs_to :lobbyist
  belongs_to :agency
  belongs_to :client
end
