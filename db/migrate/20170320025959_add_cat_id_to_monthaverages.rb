class AddCatIdToMonthaverages < ActiveRecord::Migration[5.0]
  def change
    add_column :monthaverages, :cat_ID, :integer
  end
end
