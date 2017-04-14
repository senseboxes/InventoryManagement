class CreateProductNamelists < ActiveRecord::Migration[5.0]
  def change
    create_table :product_namelists do |t|
      t.references :product, foreign_key: true
      t.references :prod_namelist, foreign_key: true

      t.timestamps
    end
  end
end
