class ChangeTableMonthaverages < ActiveRecord::Migration[5.1]
  def change
    change_column :monthaverages, :january, :decimal, :precision => 10, :scale => 3
    change_column :monthaverages, :february, :decimal, :precision => 10, :scale => 3
    change_column :monthaverages, :march, :decimal, :precision => 10, :scale => 3
    change_column :monthaverages, :april, :decimal, :precision => 10, :scale => 3
    change_column :monthaverages, :may, :decimal, :precision => 10, :scale => 3
    change_column :monthaverages, :june, :decimal, :precision => 10, :scale => 3
    change_column :monthaverages, :july, :decimal, :precision => 10, :scale => 3
    change_column :monthaverages, :august, :decimal, :precision => 10, :scale => 3
    change_column :monthaverages, :september, :decimal, :precision => 10, :scale => 3
    change_column :monthaverages, :october, :decimal, :precision => 10, :scale => 3
    change_column :monthaverages, :november, :decimal, :precision => 10, :scale => 3
    change_column :monthaverages, :december, :decimal, :precision => 10, :scale => 3
    change_column :monthaverages, :y_sum, :decimal, :precision => 10, :scale => 3
    change_column :monthaverages, :y_avg, :decimal, :precision => 10, :scale => 3
    change_column :monthaverages, :m_avg, :decimal, :precision => 10, :scale => 3
  end
end
