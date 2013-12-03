class Firm < ActiveRecord::Base
  include ModelInstanceMethods
  has_many :lobbyists
  has_many :actions, through: :lobbyists
# do_the_thing(self.lobbyists)

# def do_the_thing(collection)
# collection.map
# self.send("some_method_name")

  def set_firm_payments
    payments = self.actions.uniq.map do |action|
      action.payment
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

end
