class AddSlugsToAgencies < ActiveRecord::Migration
  def change
    add_column :agencies, :slug, :string
  end
end
