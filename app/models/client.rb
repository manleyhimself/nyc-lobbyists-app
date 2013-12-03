class Client < ActiveRecord::Base
  include ModelInstanceMethods
  has_many :actions
  has_many :lobbyists, through: :actions
  has_many :agencies, through: :actions

  def sum_all_client_payments
    payments = self.actions.map do |action|
      action.payment
    end.inject(:+)
    self.update(all_payments: payments)
  end

  def self.call_sum
    self.all.each {|client| client.sum_all_client_payments}
  end

  def self.sort_by_client_payments
    self.call_sum
    self.all.sort_by { |client| -client.all_payments }   
  end
  

end
