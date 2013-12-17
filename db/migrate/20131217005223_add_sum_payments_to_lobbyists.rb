class AddSumPaymentsToLobbyists < ActiveRecord::Migration
  def change
    add_column :lobbyists, :sum_payments, :integer
  end
end
