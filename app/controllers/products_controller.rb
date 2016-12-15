class ProductsController < ApplicationController
  before_action :set_product, only: []

# ' Create Product ' 시 ↓↓↓↓↓
  def create
    @inventory = Inventory.find(params[:inventory_id])
    cnt = @inventory.products.count
    isTrue = false
    @lastdata = @inventory.products.last 
    @recentdata = @inventory.products.new(pro_params)
    
    if( @recentdata[:puchase_kg] == nil)
      @recentdata[:puchase_kg] = 0
    end
    if(@recentdata[:release_kg] == nil)
      @recentdata[:release_kg] = 0
    end
    
    if ( cnt == 0)
      if( @recentdata[:puchase_kg] == 0 && @recentdata[:release_kg] == 0)
        flash[:msg] = '입고와 출고중 한가지는 입력하셔야 합니다.'
      else
         if( @recentdata[:puchase_kg] > 0)
           if(@recentdata[:release_kg] == 0)
            @recentdata[:stock_kg] = @recentdata[:puchase_kg]
            isTrue = true
            end
         else 
          if(@recentdata[:release_kg] > 0)
            flash[:msg] = '재고가 없습니다.'
          elsif(@recentdata[:puchase_kg] < 0 || @recentdata[:release_kg] < 0)
            flash[:msg] = '숫자만 넣어주세요.'
          elsif(@recentdata[:puchase_kg] - @recentdata[:release_kg] < 0)
            flash[:msg] = '재고가 음수입니다.'
          end
         end  
       end
  
    else
      if( @recentdata[:puchase_kg] == 0 && @recentdata[:release_kg] == 0)
        flash[:msg] = '입고와 출고중 한가지는 입력하셔야 합니다.'
      elsif(@recentdata[:puchase_kg] < 0 || @recentdata[:release_kg] < 0)
            flash[:msg] = '숫자만 넣어주세요.'
      elsif(@recentdata[:puchase_kg] - @recentdata[:release_kg] + @lastdata[:stock_kg] < 0)
            flash[:msg] = '재고가 음수입니다.' 
      else
        @recentdata[:stock_kg] = @lastdata[:stock_kg] + @recentdata[:puchase_kg] - @recentdata[:release_kg]  
        isTrue = true
      end
    end
      pro_params = @recentdata 
      respond_to do |format|
      if isTrue == true && pro_params.save
        format.html { redirect_to inventory_path(@inventory), notice: '성공적으로 저장되었습니다.' }
      else
        format.html { redirect_to inventory_path(@inventory), notice: '저장에 실패했습니다.' }
      end
    end
  end
  


# ' 해당 레코드 삭제 ' 시 ↓↓↓↓↓
  def destroy
    @inventory = Inventory.find(params[:inventory_id])
    @product = @inventory.products.find(params[:id])
    @product.destroy
    redirect_to inventory_path(@inventory)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def pro_params
    params.require(:product).permit(:pname, :puchase_kg, :release_kg, :stock_kg, :predict, :month_avg, :memo)
  end

end