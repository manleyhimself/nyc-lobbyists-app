class Lobbyist < ActiveRecord::Base
  include ModelInstanceMethods
  belongs_to :firm
  has_many :actions
  has_many :clients, through: :actions
  has_many :agencies, through: :actions
end
