class AddCategoryToInventory < ActiveRecord::Migration[5.0]
  def change
    add_reference :inventories, :category, foreign_key: true
  end
end
