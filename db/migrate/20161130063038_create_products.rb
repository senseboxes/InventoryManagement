class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :pname
      t.integer :puchase_kg
      t.integer :release_kg
      t.integer :stock_kg
      t.integer :predict
      t.integer :month_avg
      t.string :memo
      t.references :inventory, foreign_key: true
      t.references :iteminfo, foreign_key: true

      t.timestamps
    end
  end
end
