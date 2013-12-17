class Agency < ActiveRecord::Base
  include ModelInstanceMethods
  has_many :agency_actions
  has_many :actions, through: :agency_actions
  has_many :lobbyists, through: :actions
  has_many :clients, through: :actions
  
  # def self.sort_by_average_action_cost
  #   self.all.sort_by { |agency| -agency.average_action_cost}
  # end

  # def set_average_action_cost    
  #  avg = (self.actions.map(&:payment).inject(:+) / self.actions.length).round
  #  self.update(average_action_cost: avg)
  # end
      
  # def self.call_average_action_cost
  #   self.all.each {|agency| agency.set_average_action_cost}
  # end

  def set_group_payments
    payments = self.actions.map do |action|
      action.payment if action.agencies.length > 1
    end.compact.inject(:+)
    self.update(group_payments: payments) if payments
  end

  def set_solo_payments
    payments = self.actions.map do |action|
      action.payment if action.agencies.length == 1
    end.compact.inject(:+) 
    self.update(solo_payments: payments) if payments
  end

  def self.call_group_payments
    self.all.each {|agency| agency.set_group_payments}
  end

  def self.call_solo_payments
    self.all.each {|agency| agency.set_solo_payments}
  end

  def self.sort_by_sum_payments
    self.all.sort_by { |agency| -(agency.sum_payments) }
  end

  def self.set_sum_payments
    self.all.each { |agency| agency.update(sum_payments: agency.group_payments + agency.solo_payments) }
  end

  def lobbying_firms
    self.lobbyists.uniq.map do |lobbyist|
      lobbyist.firm
    end.uniq
  end

end
