class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :purpose
      t.integer :client_id
      t.boolean :admin
      t.boolean :legislative
      t.integer :payment
      t.date :begin_date
      t.date :end_date

      t.timestamps
    end
  end
end
