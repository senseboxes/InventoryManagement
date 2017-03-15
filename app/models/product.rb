class Product < ApplicationRecord
#  attr_accessor :puchase_kg, :release_kg, :stock_kg, :predict, :memo

  #validates_presence_of :stock_kg
  #validates :stock_kg, numericality: true  #stock_kg의 값은 반드시 존재해야함
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
# csv desired_columns 먼저 output
# product의 값이 desired_columns에 맞게 전부 output
#    ====결과====
#  컬럼1  컬럼3   컬럼2 ...
# 데이터1 데이터3 데이터2 ...
  def self.to_csv(options = {})
    desired_columns = ["id", "pname", "puchase_kg", "release_kg", "stock_kg", "predict", "month_avg", "memo", "inventory_id", "created_at", "updated_at"]
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*desired_columns)
      end
    end
  end

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by(id: row["id"]) || new
      product.attributes = row.to_hash
      product.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "알수없는 파일 유형 : #{file.original_filename}"
    end
  end

end
