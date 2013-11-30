class AddSlugsToLobbyists < ActiveRecord::Migration
  def change
    add_column :lobbyists, :slug, :string
  end
end
