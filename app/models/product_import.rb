class ProductImport
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include ActiveModel::Model

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

# ProductImportsController의 create에서 보냄
  def save
#   imported_products의 유효성 검사를 함
    if imported_products.map(&:valid?).all?
      imported_products.each(&:save!)
      true
    else
      imported_products.each_with_index do |product, index|
        product.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_products
# => @imported_products는 load_imported_products와 동일
    @imported_products ||= load_imported_products
  end

  def load_imported_products
# => 스프레드 시트를 작성한다. ROO라는 rails gem으로 작성
    spreadsheet = Roo::Spreadsheet.open(file.path)
# => 헤더(id, pname, puchase_kg같은 필드 네임)는 row 1번째 줄이다.
    header = spreadsheet.row(1)
# => 2번째 줄부터 마지막까지 mapping??
    (2..spreadsheet.last_row).map do |i|
# => row(1) = header, row(2) = 첫번 째 데이터 ...... i만큼의 row가 생성
      row = Hash[[header, spreadsheet.row(i)].transpose]
# => product는 Product.new와 동일 (고로 nil값을 가진 필드네임 : id:nil, pname:nil...)
      product = Product.find_by(id: row["id"]) || Product.new
# => row.to_hash값을 product.attributes로 저장
      product.attributes = row.to_hash
# => 최종적인 값은 product = load_imported_products
#      product["stock_kg"] = product["puchase_kg"] - product["release_kg"]
#      @MonthaverageController = MonthaverageController.new
#      @MonthaverageController.import_sum_monthavg(product)

      @ProductsController = ProductsController.new
      @ProductsController.import_create(product)


      product

    end
  end

end
