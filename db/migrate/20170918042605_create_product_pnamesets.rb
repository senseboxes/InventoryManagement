class CreateProductPnamesets < ActiveRecord::Migration[5.1]
  def change
    create_table :product_pnamesets do |t|
      t.references :product, foreign_key: true
      t.references :productnameset, foreign_key: true

      t.timestamps
    end
  end
end
