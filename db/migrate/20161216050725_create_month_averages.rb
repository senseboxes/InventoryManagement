class CreateMonthAverages < ActiveRecord::Migration[5.0]
  def change
    create_table :month_averages do |t|
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
      t.integer :year_index      
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
