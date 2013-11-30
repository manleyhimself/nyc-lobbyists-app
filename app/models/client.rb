class Client < ActiveRecord::Base
  include ModelInstanceMethods
  has_many :actions
  has_many :lobbyists, through: :actions
  has_many :agencies, through: :actions

end
