class AddIskKgToInventory < ActiveRecord::Migration[5.0]
  def change
    add_column :inventories, :iST_KG, :integer
  end
end
