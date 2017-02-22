class ProductImportsController < ApplicationController
#  include ActiveModel::Model
#  require ApplicationController::ProductsController

  def new
    @product_import = ProductImport.new
  end

  def create
#   product_import.rb의 Productimport class를 new하고 params를 :product_import
    @product_import = ProductImport.new(params[:product_import])
#   만약 save가 되면 product_imports_complete_path페이지로 이동하고 notice 출력

    if @product_import.save # product_import.rb의 save로 이동
#    import_lastdata_receive
#    @product_import.each(&:save!)
      redirect_to product_imports_path, notice: "Imported products successfully."
#   실패하면 new페이지로 이동 (import페이지)
    else
      render :new
    end
  end
  
  def index
    @products = Product.all
  end

end
