class AddAllPaymentsToFirms < ActiveRecord::Migration
  def change
    add_column :firms, :all_payments, :integer
  end
end
