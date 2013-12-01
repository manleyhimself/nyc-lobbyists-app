class Lobbyist < ActiveRecord::Base
  include ModelInstanceMethods
  belongs_to :firm
  has_many :actions
  has_many :clients, through: :actions
  has_many :agencies, through: :actions

  def sum_all_payments
    payments = self.actions.map do |action|
      action.payment
    end.inject(:+)
    self.update(all_payments: payments)
  end

  def self.call_sum
    self.all.each {|lobbyist| lobbyist.sum_all_payments}
  end

  def self.sort_by_payments
    self.call_sum
    self.all.sort_by { |lobbyist| -lobbyist.all_payments }
  end

end
