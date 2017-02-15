require 'csv'

class Product < ApplicationRecord
  #validates_presence_of :stock_kg
  validates :stock_kg, numericality: true
  belongs_to :inventory
  self.per_page = 10

#  def self.to_csv(options = {})
#    CSV.generate(options) do |csv|
#      csv << column_names
#      all.each do |product|
#      csv << product.attributes.values
#      end
#    end
#  end

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
