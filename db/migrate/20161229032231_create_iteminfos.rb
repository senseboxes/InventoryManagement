class CreateIteminfos < ActiveRecord::Migration[5.0]
  def change
    create_table :iteminfos do |t|
      t.integer :inputID
      t.integer :categoryID
      t.string :name
      t.string :reserve1_s
      t.string :reserve2_s
      t.string :reserve3_s
      t.string :reserve4_s
      t.string :reserve5_s
      t.integer :reserve1_i
      t.integer :reserve2_i
      t.integer :reserve3_i
      t.integer :reserve4_i
      t.integer :reserve5_i
      t.boolean :bool1
      t.boolean :bool2
      t.text :text      

      t.timestamps
    end
  end
end
