class AddAllPaymentsToLobbyists < ActiveRecord::Migration
  def change
    add_column :lobbyists, :all_payments, :integer
  end
end
