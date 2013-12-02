class Firm < ActiveRecord::Base
  include ModelInstanceMethods
  has_many :lobbyists
  has_many :actions, through: :lobbyists
# do_the_thing(self.lobbyists)

# def do_the_thing(collection)
# collection.map
# self.send("some_method_name")

  def set_firm_payments()
    payments = self.lobbyists.map do |lobbyist|
      lobbyist.actions.map do |action|
        action.payment
      end
    end.flatten.inject(:+)
    self.update(all_payments: payments)
  end

  def self.call_sum
    self.all.each {|firm| firm.set_firm_payments}
  end

  def self.sort_by_firm_payments
    self.call_sum
    self.all.sort_by { |firm| -firm.all_payments }   
  end

  def find_clients_and_payments
    client_payments_hash = {}  #key: client.name value: action.payment_sum
    self.actions.uniq.sort_by { |action| action.client.name }.each do |action|
      if !client_payments_hash.keys.include?(action.client.name) 
        client_payments_hash[action.client.name] = action.payment
      else 
         client_payments_hash[action.client.name] += action.payment
      end
    end
    client_payments_hash
  end

  def find_agencies
    self.lobbyists.map do |lobbyist|
      lobbyist.agencies
    end.flatten.uniq.length
  end

end
