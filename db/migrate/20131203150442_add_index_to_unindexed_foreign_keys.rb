class AddIndexToUnindexedForeignKeys < ActiveRecord::Migration
  def change
    add_index :actions, :client_id
    add_index :actions, :payment
    add_index :firms, :all_payments
    add_index :lobbyists, :firm_id
    add_index :lobbyists, :my_payments
    add_index :lobbyists, :team_payments
    add_index :clients, :all_payments


  end
end
