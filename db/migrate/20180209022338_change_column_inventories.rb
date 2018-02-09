class ChangeColumnInventories < ActiveRecord::Migration[5.1]
  def change
    change_column :inventories, :iST_KG, :decimal, :precision => 10, :scale => 3
  end
end
