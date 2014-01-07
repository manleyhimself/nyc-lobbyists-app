indeclass CreateLobbyistActions < ActiveRecord::Migration
  def change
    create_table :lobbyist_actions do |t|
      t.references :action, index: true
      t.references :lobbyist, index: true

      t.timestamps
    end
  end
end
