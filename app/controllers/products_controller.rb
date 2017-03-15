class ProductsController < ApplicationController
  before_action :set_product, only: []

# index 페이지에서 export하기 위한 액션
  def index
    @products = Product.order(:created_at)
    respond_to do |format|
      format.html
      format.csv { send_data @products.to_csv }
      format.xls #  { send_data @products.to_csv(col_sep: "\t") }
    end
  end

  def import
    Product.import(params[:file])
    redirect_to root_url, notice: 'Products imported.'
  end

  # EditBox에서 입고, 출고, 재고를 입력받아 사용상에 문제가 없는지 체크한다.
  # 계산상에 문제가 없다면 true를 리턴한다.
  def check_inout(puchase_kg, release_kg, stock_kg)
    isTrue = false

    if( puchase_kg == 0 && release_kg == 0)                                 #입고와 출고를 모두 입력하지 않은 경우
        flash[:msg] = '입고와 출고중 한가지는 입력하셔야 합니다.'
    elsif(puchase_kg < 0 || release_kg < 0)                                     #입고와 출고를 음수나 0을 넣은 경우
          flash[:msg] = '숫자만 넣어주세요.'
    elsif(puchase_kg - release_kg + stock_kg < 0)                             #입고와 출고의 계산값이 재고보다 클 경우
          flash[:msg] = '재고가 음수입니다.'
    else
      isTrue = true
    end

    return isTrue
  end

  # 재고리스트가 '0'일 경우에만 호출한다.
  def set_stock_zero(puchase_kg, release_kg)
     if( puchase_kg > 0)
       if(release_kg == 0)                            #입고만 입력하고 출고는 입력하지 않은경우 재고에 입고값을 넣어준다.
          return puchase_kg
        elsif(release_kg > 0)                         #입고와 출고 모두 입력한 경우
          return puchase_kg - release_kg
        end
      end
  end

# ' Create Product ' 시 ↓↓↓↓↓
  def create
    @inventory = Inventory.find(params[:inventory_id])
    cnt = @inventory.products.count
    isTrue = false
    @lastdata = @inventory.products.last
    @recentdata = @inventory.products.new(pro_params)


    # 입고나 출고가 nil일 경우 0으로 초기화 한다.
    if( @recentdata[:puchase_kg] == nil)
      @recentdata[:puchase_kg] = 0
    end
    if( @recentdata[:release_kg] == nil)
      @recentdata[:release_kg] = 0
    end

    if ( cnt == 0)  #재고리스트가 비어있는 경우
      @recentdata[:stock_kg] = 0        #인자로 넘어갈 값이 nil일 경우 계산에 문제가 생길 수 있으므로 초기화한다.
      if(!check_inout(@recentdata[:puchase_kg], @recentdata[:release_kg], @recentdata[:stock_kg]))
        isTrue = false
      else
        @recentdata[:stock_kg] = set_stock_zero(@recentdata[:puchase_kg], @recentdata[:release_kg])
         if( @recentdata[:stock_kg] > 0)
           isTrue = true
         end
      end


    else            #재고리스트가 한개라도 존재하는 경우
      if(!check_inout(@recentdata[:puchase_kg], @recentdata[:release_kg], @lastdata[:stock_kg]))
        isTrue = false
      else
        @recentdata[:stock_kg] = @lastdata[:stock_kg] + @recentdata[:puchase_kg] - @recentdata[:release_kg]
        isTrue = true
      end
    end
      pro_params = @recentdata
      respond_to do |format|
      if isTrue == true && pro_params.save
        @MonthaverageController = MonthaverageController.new
        @MonthaverageController.set_usertime(@recentdata[:created_at])
        @MonthaverageController.sum_monthavg(params, @recentdata)
        format.html { redirect_to inventory_path(@inventory), notice: '성공적으로 저장되었습니다.' }
      else
        format.html { redirect_to inventory_path(@inventory), notice: '저장에 실패했습니다.' }
      end
    end

  end

# => import create 시
  def import_create(product)
    @inventory = Inventory.find(product["inventory_id"])
    cnt = @inventory.products.count
    isTrue = false
    @lastdata = @inventory.products.last


    # 입고나 출고가 nil일 경우 0으로 초기화 한다.
    if( product["puchase_kg"] == nil)
      product["puchase_kg"] = 0
    end
    if( product["release_kg"] == nil)
      product["release_kg"] = 0
    end

    if ( cnt == 0)  #재고리스트가 비어있는 경우
      product["stock_kg"] = 0        #인자로 넘어갈 값이 nil일 경우 계산에 문제가 생길 수 있으므로 초기화한다.
      if(!check_inout(product["puchase_kg"], product["release_kg"], product["stock_kg"]))
        isTrue = false
      else
        product["stock_kg"] = set_stock_zero(product["puchase_kg"], product["release_kg"])
         if( product["stock_kg"] > 0)
           isTrue = true
         end
      end


    else            #재고리스트가 한개라도 존재하는 경우
      if(!check_inout(product["puchase_kg"], product["release_kg"], @lastdata[:stock_kg]))
        isTrue = false
      else
        product["stock_kg"] = @lastdata[:stock_kg] + product["puchase_kg"] - product["release_kg"]
        isTrue = true
      end
    end
      pro_params = product
#      respond_to do |format|
      isTrue == true && pro_params.save
      @MonthaverageController = MonthaverageController.new
      @MonthaverageController.import_sum_monthavg(product)
#        format.html { redirect_to product_imports_path, notice: '성공적으로 저장되었습니다.' }
#      else
#        format.html { redirect_to product_imports_path, notice: '저장에 실패했습니다.' }
#      end
#    end

  end

# ' 해당 레코드 삭제 ' 시 ↓↓↓↓↓
  def destroy
    @inventory = Inventory.find(params[:inventory_id])
    @product = @inventory.products.find(params[:id])
    @product.destroy

    @MonthaverageController = MonthaverageController.new
    @MonthaverageController.month_minus(@product)
    redirect_to inventory_path(@inventory)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def pro_params
    params.require(:product).permit(:pname, :puchase_kg, :release_kg, :stock_kg, :predict, :month_avg, :memo, :created_at)
  end

end
