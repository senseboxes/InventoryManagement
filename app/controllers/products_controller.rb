class ProductsController < ApplicationController
  before_action :set_product, only: []
  require 'time'
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
  
  def make_monthavg()
    @monthaverages[:inventory_id] = @inventory[:id]
    @monthaverages[:inven_name] = @inventory[:iname]
    @monthaverages[:january] = 0
    @monthaverages[:february] = 0
    @monthaverages[:march] = 0
    @monthaverages[:april] = 0
    @monthaverages[:may] = 0
    @monthaverages[:june] = 0
    @monthaverages[:july] = 0
    @monthaverages[:august] = 0
    @monthaverages[:september] = 0
    @monthaverages[:october] = 0
    @monthaverages[:november] = 0
    @monthaverages[:december] =  0
    @monthaverages[:january_c] = 0
    @monthaverages[:february_c] = 0
    @monthaverages[:march_c] = 0
    @monthaverages[:april_c] = 0
    @monthaverages[:may_c] = 0
    @monthaverages[:june_c] = 0
    @monthaverages[:july_c] = 0
    @monthaverages[:august_c] = 0
    @monthaverages[:september_c] = 0
    @monthaverages[:october_c] = 0
    @monthaverages[:november_c] = 0
    @monthaverages[:december_c] =  0
    @monthaverages.save(:validate => false)  #  (:validate => false)는 검증을 예외처리
    return true
  end 

  # 새로운 함수 호출
  # 월 합산o, 월 사용 카운트[월에 몇번을 생산했는지 카운트 기록], 월평균 사용량o, 회당 평균 사용량, 년합산o
  def sum_monthavg(recent_proparams)  #recent_proparams = @recentdata
    time = Time.new
    @monthaverages = Monthaverage.find_by(inventory_id: recent_proparams[:inventory_id], y_index: time.year ) # inventor_id = 1이면서 현재 연 필드 불러오기
    #fine_by 검색에 실패했을 경우
    if ( @monthaverages == nil )
      @monthaverages = Monthaverage.new(monthavg_params)               #@monthaverages 만들고
      make_monthavg()                                                                   # 초기화 하고
      @monthaverages[:inventory_id] = recent_proparams[:inventory_id]     # ID 셋팅하고
      @monthaverages[:y_index] = time.year                                        # 년도 셋팅한다.
    end
    
    case time.month
    when 1
      @monthaverages[:january] += recent_proparams[:release_kg]
      @monthaverages[:january_c] += 1          
    when 2
      @monthaverages[:february] += recent_proparams[:release_kg]
      @monthaverages[:february_c] += 1
    when 3
      @monthaverages[:march] += recent_proparams[:release_kg]
      @monthaverages[:march_c] += 1
    when 4
      @monthaverages[:april] += recent_proparams[:release_kg]
      @monthaverages[:april_c] += 1
    when 5
      @monthaverages[:may] += recent_proparams[:release_kg]
      @monthaverages[:may_c] += 1
    when 6
      @monthaverages[:june] += recent_proparams[:release_kg]
      @monthaverages[:june_c] += 1
    when 7
      @monthaverages[:july] += recent_proparams[:release_kg]
      @monthaverages[:july_c] += 1
    when 8
      @monthaverages[:august] += recent_proparams[:release_kg]
      @monthaverages[:august_c] += 1
    when 9
      @monthaverages[:september] += recent_proparams[:release_kg]
      @monthaverages[:september_c] += 1
    when 10
      @monthaverages[:october] += recent_proparams[:release_kg]
      @monthaverages[:october_c] += 1
    when 11
      @monthaverages[:november] += recent_proparams[:release_kg]
      @monthaverages[:november_c] += 1
    when 12
      @monthaverages[:december] += recent_proparams[:release_kg]
      @monthaverages[:december_c] += 1
    end
    @monthaverages.save

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
        sum_monthavg(@recentdata)
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
    params.require(:product).permit(:pname, :puchase_kg, :release_kg, :stock_kg, :predict, :month_avg, :memo, :created_at)
  end

end