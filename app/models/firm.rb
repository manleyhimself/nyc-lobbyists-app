class Firm < ActiveRecord::Base
  include ModelInstanceMethods
  has_many :lobbyists

  def sum_all_firm_payments
    payments = self.lobbyists.map do |lobbyist|
      lobbyist.all_payments
    end.inject(:+)
    self.update(all_payments: payments)
  end

  def self.call_sum
    self.all.each {|firm| firm.sum_all_firm_payments}
  end

  def self.sort_by_firm_payments
    self.call_sum
    self.all.sort_by { |firm| -firm.all_payments }   
  end
  
end
