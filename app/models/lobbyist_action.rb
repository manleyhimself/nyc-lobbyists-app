class LobbyistAction < ActiveRecord::Base
  belongs_to :action
  belongs_to :lobbyist
end
