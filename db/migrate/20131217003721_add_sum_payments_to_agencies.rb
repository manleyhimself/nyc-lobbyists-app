class AddSumPaymentsToAgencies < ActiveRecord::Migration
  def change
    add_column :agencies, :sum_payments, :integer
  end
end
