class Product < ApplicationRecord
  belongs_to :inventory
  has_many :product_productnamesets
  has_many :productnamesets, through: :product_productnamesets

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
