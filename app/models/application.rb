class Application < ActiveRecord::Base

  def self.model_call_setters
    Agency.call_solo_payments
    Agency.call_group_payments
    Agency.set_sum_payments

    Lobbyist.call_team_payments
    Lobbyist.call_my_payments
    Lobbyist.set_sum_payments

    Client.call_sum

    Firm.call_sum
  end

end