class AddSoloPaymentToAgencies < ActiveRecord::Migration
  def change
    add_column :agencies, :solo_payments, :integer, default: 0
  end
end
