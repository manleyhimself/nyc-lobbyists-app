class AddTeamPaymentsToLobbyists < ActiveRecord::Migration
  def change
    add_column :lobbyists, :team_payments, :integer
  end
end
