class CreateInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :inventories do |t|
      t.string :iname
      t.integer :inputID
      t.integer :categoryID
#      t.integer :inven_stock
      t.boolean  :bool1
      t.boolean  :bool2
      t.text  :text
      
      t.timestamps
    end
  end
end
