class CreateInvinfos < ActiveRecord::Migration[5.0]
  def change
    create_table :invinfos do |t|
      t.string :iiname
      t.integer :iinputID
      t.integer :icategoryID
      t.boolean  :ibool1
      t.boolean  :ibool2
      t.text  :itext      
      t.string   :reserve1_s
      t.string   :reserve2_s
      t.string   :reserve3_s
      t.string   :reserve4_s
      t.string   :reserve5_s
      t.integer  :reserve1_i
      t.integer  :reserve2_i
      t.integer  :reserve3_i
      t.integer  :reserve4_i
      t.integer  :reserve5_i
      
      t.timestamps
    end
  end
end
