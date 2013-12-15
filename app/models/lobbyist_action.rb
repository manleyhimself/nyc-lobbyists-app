class LobbyistAction < ActiveRecord::Base
  belongs_to :action, touch: true
  belongs_to :lobbyist, touch: true
end
