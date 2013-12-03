class AddAverageActionCostToAgencies < ActiveRecord::Migration
  def change
    add_column :agencies, :average_action_cost, :integer, default: 0
  end
end
