class AddPaymentsToClients < ActiveRecord::Migration
  def change
    add_column :clients, :all_payments, :integer
  end
end
