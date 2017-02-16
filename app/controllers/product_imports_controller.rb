class ProductImportsController < ApplicationController
  include ActiveModel::Model

  def new
    @product_import = ProductImport.new
  end

  def create
    @product_import = ProductImport.new(params[:product_import])
    inventory_C = Inventory.count


    if @product_import.save
      import_invenID = @product_import
      save
      redirect_to product_imports_complete_path, notice: "Imported products successfully."
    else
      render :new
    end
  end

  def complete
    @products = Product.all
  end

end
