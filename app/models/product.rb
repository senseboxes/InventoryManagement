# Export를 위한 csv 요청
require 'csv'

class Product < ApplicationRecord
  #validates_presence_of :stock_kg
  validates :stock_kg, numericality: true  #stock_kg의 값은 반드시 존재해야함
  belongs_to :inventory
  self.per_page = 10 # 1페이지에 데이터를 10개만 보여줘 : 넘으면 다음 페이지를 생성

#  def self.to_csv(options = {})
#    CSV.generate(options) do |csv|
#      csv << column_names
#      all.each do |product|
#      csv << product.attributes.values
#      end
#    end
#  end

# Export 할 때 이와 같은 구조로 출력이 됨
# csv desired_columns 먼저 input
# product의 값이 desired_columns에 맞게 전부 input
#    ====결과====
#  컬럼1  컬럼3   컬럼2 ...
# 데이터1 데이터3 데이터2 ...
  def self.to_csv(options = {})
    desired_columns = ["id", "pname", "puchase_kg", "release_kg", "stock_kg", "predict", "month_avg", "memo", "inventory_id", "created_at", "updated_at"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |product|
        csv << product.attributes.values_at(*desired_columns)
      end
    end
  end
end
