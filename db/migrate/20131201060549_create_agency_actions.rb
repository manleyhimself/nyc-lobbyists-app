class CreateAgencyActions < ActiveRecord::Migration
  def change
    create_table :agency_actions do |t|
      t.references :agency, index: true
      t.references :action, index: true

      t.timestamps
    end
  end
end
