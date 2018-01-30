class AddpcategoryIdToProductnamesets < ActiveRecord::Migration[5.1]
  def change
    add_reference :productnamesets, :category, foreign_key: true
  end
end
