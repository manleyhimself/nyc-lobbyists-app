class AddSlugsToFirms < ActiveRecord::Migration
  def change
    add_column :firms, :slug, :string
  end
end
