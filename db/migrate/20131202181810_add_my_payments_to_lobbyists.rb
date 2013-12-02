class AddMyPaymentsToLobbyists < ActiveRecord::Migration
  def change
    add_column :lobbyists, :my_payments, :integer
  end
end
