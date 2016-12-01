class ProductsController < ApplicationController
  def create
    @inventory = Inventory.find(params[:inventory_id])
    @product = @inventory.products.create(pro_params)
    redirect_to inventory_path(@inventory)
  end
  
  def destroy
    @inventory = Inventory.find(params[:inventory_id])
    @product = @inventory.products.find(params[:id])
    @product.destroy
    redirect_to inventory_path(@inventory)
  end
  
  def avg
    @inventory = Inventory.find(params[:inventory_id])
    @product = @inventory.products.group(pro_params).average(:month_avg)
    redirect_to inventory_path(@inventory)
  end
  
  def pro_params
    params.require(:product).permit(:pname, :puchase_kg, :release_kg, :stock_kg, :predict, :month_avg, :memo)
  end
  
end
