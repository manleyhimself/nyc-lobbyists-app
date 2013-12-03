class AddGroupPaymentToAgencies < ActiveRecord::Migration
  def change
    add_column :agencies, :group_payments, :integer, default: 0
  end
end
