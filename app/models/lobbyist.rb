class Lobbyist < ActiveRecord::Base
  include ModelInstanceMethods
  belongs_to :firm, touch: true
  has_many :lobbyist_actions
  has_many :actions, through: :lobbyist_actions
  has_many :clients, through: :actions
  has_many :agencies, through: :actions

  def set_my_payments
    payments = self.actions.map do |action|
      action.payment if action.lobbyists.length == 1
    end.compact.inject(:+) 
    self.update(my_payments: payments) if payments
  end

  def self.call_my_payments
    self.all.each {|lobbyist| lobbyist.set_my_payments}
  end

  def self.sort_by_my_payments
    self.all.sort_by { |lobbyist| -lobbyist.my_payments }
  end

  def set_team_payments
    payments = self.actions.map do |action|
      action.payment if action.lobbyists.length > 1
    end.compact.inject(:+)
    self.update(team_payments: payments) if payments
  end

  def self.call_team_payments
    self.all.each {|lobbyist| lobbyist.set_team_payments}
  end

  def self.sort_by_team_payments
    self.all.sort_by { |lobbyist| -lobbyist.team_payments }
  end

  def self.sort_by_sum_payments
    self.all.sort_by { |lobbyist| -(lobbyist.sum_payments) }
  end

  def self.set_sum_payments
    self.all.each { |lobbyist| lobbyist.update(sum_payments: lobbyist.team_payments + lobbyist.my_payments) }
  end

end
