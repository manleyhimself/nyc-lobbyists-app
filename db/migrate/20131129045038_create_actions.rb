class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :purpose
      t.integer :lobbyist_id
      t.integer :client_id
      t.integer :agency_id
      t.boolean :admin
      t.boolean :legislative
      t.integer :payment

      t.timestamps
    end
  end
end
