class Firm < ActiveRecord::Base
  include ModelInstanceMethods
  has_many :lobbyists

end
