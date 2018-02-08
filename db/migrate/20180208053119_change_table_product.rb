class ChangeTableProduct < ActiveRecord::Migration[5.1]
  def change #소수점 입력을 위해 데이터 타입을 변경함
    change_column :products, :puchase_kg, :decimal, :precision => 10, :scale => 3
    change_column :products, :release_kg, :decimal, :precision => 10, :scale => 3
    change_column :products, :stock_kg, :decimal, :precision => 10, :scale => 3
    change_column :products, :predict, :decimal, :precision => 10, :scale => 3
    change_column :products, :month_avg, :decimal, :precision => 10, :scale => 3
  end
end
