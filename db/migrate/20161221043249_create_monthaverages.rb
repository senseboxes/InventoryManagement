class CreateMonthaverages < ActiveRecord::Migration[5.0]
  def change
    create_table :monthaverages do |t|
      t.string :inven_name
      t.integer :january
      t.integer :february
      t.integer :march
      t.integer :april
      t.integer :may
      t.integer :june
      t.integer :july
      t.integer :august
      t.integer :september
      t.integer :october
      t.integer :november
      t.integer :december
      t.integer :january_c
      t.integer :february_c
      t.integer :march_c
      t.integer :april_c
      t.integer :may_c
      t.integer :june_c
      t.integer :july_c
      t.integer :august_c
      t.integer :september_c
      t.integer :october_c
      t.integer :november_c
      t.integer :december_c
      t.integer :y_sum
      t.integer :y_avg
      t.integer :m_avg
      t.integer :y_index
      t.integer :m_index          
      t.references :inventory, foreign_key: true

      t.timestamps
    end
  end
end
