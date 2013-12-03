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
  
  
  def find_lobbyists_and_payments
    # {lobbyist.name 
    # => [action.client.my_payment_sum,
    #     action.client.team_payment_sum]}
    lobbyist_payments_hash = {} 
    self.actions.each do |action|
      action.lobbyists.each do |lobbyist|
        if !lobbyist_payments_hash.keys.include?(lobbyist) 
          lobbyist_payments_hash[lobbyist] ||= [0,0]
          single_lobbyist = (action.lobbyists.length == 1)
          lobbyist_payments_hash[lobbyist][0] = (single_lobbyist ? action.payment : 0)
          lobbyist_payments_hash[lobbyist][1] = (single_lobbyist ? 0 : action.payment)
        else 
          single_lobbyist = (action.lobbyists.length == 1)
          lobbyist_payments_hash[lobbyist][0] += (single_lobbyist ? action.payment : 0)
          lobbyist_payments_hash[lobbyist][1] += (single_lobbyist ? 0 : action.payment)
        end
      end
    end
    lobbyist_payments_hash
  end

end
