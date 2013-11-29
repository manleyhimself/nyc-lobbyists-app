class CreateLobbyists < ActiveRecord::Migration
  def change
    create_table :lobbyists do |t|
      t.string :name
      t.integer :firm_id

      t.timestamps
    end
  end
end
