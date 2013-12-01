class Action < ActiveRecord::Base
  has_and_belongs_to_many :lobbyist
  has_and_belongs_to_many :agency
  belongs_to :client

end
