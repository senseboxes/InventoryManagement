class CreateCategoryinfos < ActiveRecord::Migration[5.0]
  def change
    create_table :categoryinfos do |t|
      t.string :category
      
      t.timestamps
    end
  end
end
