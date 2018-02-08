class AddIskKgToInventory < ActiveRecord::Migration[5.0]
  def change
    add_column :inventories, :iST_KG, :decimal, :precision => 10, :scale => 3
  end
end
