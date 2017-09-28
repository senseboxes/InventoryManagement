require 'time'
class ProductsController < ApplicationController
  before_action :set_product, only: [:update_product, :destroy]
@@find_record = 0
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
    if( puchase_kg == 0 && release_kg == 0)                                 #입고와 출고를 모두 입력하지 않은 경우
        flash[:notice] = '입고와 출고중 한가지는 입력하셔야 합니다.'
        isTrue = false
    elsif(puchase_kg < 0 || release_kg < 0)                                     #입고와 출고를 음수나 0을 넣은 경우
        flash[:notice] = '숫자만 넣어주세요.'
        isTrue = false
    elsif(puchase_kg - release_kg + stock_kg < 0)                             #입고와 출고의 계산값이 재고보다 클 경우
        flash[:notice] = '재고가 음수입니다.'
        isTrue = false
    else
      isTrue = true
    end
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

=begin
      날짜가 입력된다.
      입력된 날짜(input_date)와 현재 날짜(now_date)를 between으로 db에서 검색한다.
      검색해온 값들과 새로입력한 값을 계산하고 값이 변한 상수를 def update로 넘겨주고 save
      새로 입력된 값은 create에서 save

      만약 새로 입력된 데이터가 오늘 날짜와 틀리다면 a 같다면 b

      recent_chk => create 함수의 @recentdata(지금입력된 데이터의 값들)
      search_date => 지금 입력된 데이터의 created_at를 불러옴 년/월/일/시/분/초
      now_date => 현재 시간의 년/월/일/시/분/초
      arr_date => search_date부터 now_date까지 products테이블에서 전부 불러옴
      record_c => arr_date의 레코드가 몇 개인지 체크
      now - 24.hours       => Sun, 02 Nov 2014 01:26:28 EDT -04:00
      now - 1.day          => Sun, 02 Nov 2014 00:26:28 EDT -04:00
=end
  # 시간 기준으로 계산을 한다.
  def chk_date(recent_chk)
    @@find_record = 0
    search_date = recent_chk[:created_at]
    now_date = Time.zone.now
    arr_date = @inventory.products.where("created_at BETWEEN ? AND ?", search_date, now_date).order(created_at: :ASC)
    #가장 마지막(즉)
    #asc:오름차순-> 1,2,3,4,5 // desc:내림차순 -> 5,4,3,2,1
    table_data_c = @inventory.products.where(inventory_id: recent_chk[:inventory_id]).count
    record_c = arr_date.records.count
# @recentdata를 어떻게 보낼 것인가 ...
# 재고 중간에 삽입
    if record_c > 0 && record_c != table_data_c
      if recent_chk[:puchase_kg] - recent_chk[:release_kg] < arr_date[0].stock_kg
        update_product(arr_date, record_c, recent_chk)
        @@find_record = 1
      end
# 재고리스트 가장 마지막에 등록
    elsif record_c == 0
      @@find_record = 2
# 재고리스트 가장 처음에 등록
    else
      if recent_chk[:puchase_kg] > recent_chk[:release_kg]
        update_lowrank(arr_date, record_c, recent_chk)
        @@find_record = 3
      end
    end
  end
=begin
  arr_record => 언제부터 언제까지 날짜로 검색한 데이터들
  record_c => 위의 데이터들의 갯수
  recent_chk => @recentdata
=end
  def update_product(arr_record, record_c, recent_chk)
    # 검색할 날짜(search_date)부터 현재 날짜(now_date)까지의 레코드(데이터) => arr_date[n개]
    real_record = arr_record[0]
    real_record_stock = real_record[:stock_kg] + real_record[:release_kg] - real_record[:puchase_kg]
    recent_chk[:stock_kg] = real_record_stock + recent_chk[:puchase_kg] - recent_chk[:release_kg]
    real_record[:stock_kg] = recent_chk[:stock_kg] + real_record[:puchase_kg] - real_record[:release_kg]
    # (arr_date중에서 가장 첫[0] 번째) 데이터를 pro_params에 대입
    pro_params = real_record
    # pro_params 저장
    pro_params.save
    # 여기서부터는 (arr_date의 두 번째 레코드부터 업데이트)
    n = 1
    while n < record_c
      # n 번째 레코드의 재고중량 = n-1 번째 재고중량(n번째의 바로 전 데이터와 계산해야하기 때문에 n-1이 됨) - 출고중량 + 입고중량
      arr_record[n].stock_kg = arr_record[n-1].stock_kg + arr_record[n].puchase_kg - arr_record[n].release_kg
      pro_params = arr_record[n]
      pro_params.save
      n += 1
    end
  end

  def update_lowrank(arry_record, record_c, recent_chk)
    record_no = arry_record[0]
    record_no_stock = record_no[:stock_kg] + recent_chk[:puchase_kg] - recent_chk[:release_kg]
    record_no[:stock_kg] = record_no_stock
    pro_params = record_no
    pro_params.save
    n = 1
    while n < record_c
      arry_record[n].stock_kg = arry_record[n-1].stock_kg + arry_record[n].puchase_kg - arry_record[n].release_kg
      pro_params = arry_record[n]
      pro_params.save
      n += 1
    end
  end

# ' Create Product ' 시 ↓↓↓↓↓
  def create
    isTrue = false
    @inventory = Inventory.find(params[:inventory_id])
    cnt = @inventory.products.count
    @lastdata = @inventory.products.order("created_at").last # 날짜 기준으로 마지막데이터를 불러옴
    @recentdata = @inventory.products.new(pro_params)
    # 입고나 출고가 nil일 경우 0으로 초기화 한다.
    if( @recentdata[:puchase_kg] == nil)
      @recentdata[:puchase_kg] = 0
    end
    if( @recentdata[:release_kg] == nil)
      @recentdata[:release_kg] = 0
    end

    if ( cnt == 0 )  #재고리스트가 비어있는 경우
      @recentdata[:stock_kg] = 0        #인자로 넘어갈 값이 nil일 경우 계산에 문제가 생길 수 있으므로 초기화한다.
      if(!check_inout(@recentdata[:puchase_kg], @recentdata[:release_kg], @recentdata[:stock_kg]))
        isTrue = false
      else
        @recentdata[:stock_kg] = set_stock_zero(@recentdata[:puchase_kg], @recentdata[:release_kg])
         if( @recentdata[:stock_kg] > 0)
           isTrue = true
         end
      end

=begin
기존 레코드는 존재하는데 날짜를 등록된 레코드 날짜보다 전으로 선택
첫번째 레코드 저장일 때 ....
전역변수? 지역변수?
@lastdata = 모든 레코드중에서 가장 최근 날짜
@fs_lastdata = 모든 레코드중에서 가장 오래된 날짜의 레코드

변수가 1이면 a식 실행
변수가 없거나 또는 2이면 b식 실행

return은 값을 반환하지못함 ... only true, false만 인듯
=end

    else            #재고리스트가 한개라도 존재하는 경우

      chk_date(@recentdata)
          # 재고 중간에 등록
        if @@find_record == 1
          fr1_sear_date = @recentdata[:created_at]
          fr1_now_date = Time.zone.now
          @fr1_lastdata = @inventory.products.where("created_at BETWEEN ? AND ?", fr1_sear_date, fr1_now_date).order("created_at")
          if check_inout(@recentdata[:puchase_kg], @recentdata[:release_kg], @fr1_lastdata[0].stock_kg) == true
            #@recentdata[:stock_kg] = @fr1_lastdata[0].stock_kg + @recentdata[:puchase_kg] - @recentdata[:release_kg]
            isTrue = true
          else
            isTrue = false
          end
          # 재고 가장 마지막에 등록
        elsif @@find_record == 2
          # ASC : 오름차순 , DESC : 내림차순 ( ASC는 생략해도 됨 ; 기본이 ASC )
          @fr2_lastdata = @inventory.products.order("created_at").last
          if check_inout(@recentdata[:puchase_kg], @recentdata[:release_kg], @fr2_lastdata[:stock_kg]) == true
            @recentdata[:stock_kg] = @fr2_lastdata[:stock_kg] + @recentdata[:puchase_kg] - @recentdata[:release_kg]
            isTrue = true
          else
            isTrue = false
          end
        # 재고 가장 처음에 등록
        elsif @@find_record == 3
          @fr3_firstdata = @inventory.products.order("created_at").first
          if check_inout(@recentdata[:puchase_kg], @recentdata[:release_kg], @recentdata[:puchase_kg]) == true
            @recentdata[:stock_kg] = @recentdata[:puchase_kg] - @recentdata[:release_kg]
            isTrue = true
          else
            isTrue = false
          end
        else

        end
    end
      pro_params = @recentdata
      respond_to do |format|
      if isTrue == true && pro_params.save
        @MonthaverageController = MonthaverageController.new
        @MonthaverageController.set_usertime(@recentdata[:created_at])
        @MonthaverageController.sum_monthavg(params, @recentdata, @inventory)
        @InventoriesController = InventoriesController.new
        @InventoriesController.stock_Sum(pro_params)
        format.html { redirect_to inventory_path(@inventory), notice: '성공적으로 저장되었습니다.' }
      else
        format.html { redirect_to inventory_path(@inventory), notice: '저장에 실패했습니다.' }
      end
    end
  end

  # 보낸곳_받는곳_받은목적_실행목적(보낸 변수의 첫글자를 따서 변수명으로 지정)
  def monthaverage_pro_monthvalue_save(ma_value)
    if ma_value != nil
      @inventory = Inventory.find(ma_value[:inventory_id])
      @m_avg_save = @inventory.products.last
      if @m_avg_save != nil
      @m_avg_save[:month_avg] = ma_value[:m_avg]
      @m_avg_save.save
      else
        return
      end
    end
  end

  # => import create 시
  def import_create(product)
    @inventory = Inventory.find(product["inventory_id"])
    cnt = @inventory.products.count
    isTrue = false
    @lastdata = @inventory.products.last

    if( product["puchase_kg"] == nil)
      product["puchase_kg"] = 0
    end
    if( product["release_kg"] == nil)
      product["release_kg"] = 0
    end

    if ( cnt == 0)
      product["stock_kg"] = 0
      if(!check_inout(product["puchase_kg"], product["release_kg"], product["stock_kg"]))
        isTrue = false
      else
        product["stock_kg"] = set_stock_zero(product["puchase_kg"], product["release_kg"])
         if( product["stock_kg"] > 0)
           isTrue = true
         end
      end


    else
      if(!check_inout(product["puchase_kg"], product["release_kg"], @lastdata[:stock_kg]))
        isTrue = false
      else
        product["stock_kg"] = @lastdata[:stock_kg] + product["puchase_kg"] - product["release_kg"]
        isTrue = true
      end
    end
      pro_params = product
      isTrue == true && pro_params.save
      @MonthaverageController = MonthaverageController.new
      @MonthaverageController.import_sum_monthavg(product)

  end

# ' 해당 레코드 삭제 ' 시 ↓↓↓↓↓
  def destroy
    @inventory = Inventory.find(params[:inventory_id])
    @product = @inventory.products.find(params[:id])
    # puchase_kg와 release_kg 값을 빼주는 식
    # 여기도 create처럼 처음데어터 삭제냐? 중간데이터 삭제냐? 마지막 데이터삭제냐?의 조건식을 만들어야 할 듯....
    # 조건은?
    @product.destroy
    @lastdata = @inventory.products.last
    @InventoriesController = InventoriesController.new
    @InventoriesController.pro_delete(@lastdata, @inventory)
    @MonthaverageController = MonthaverageController.new
    @MonthaverageController.month_minus(@product)
    redirect_to inventory_path(@inventory)
  end

  def new
    @product = Product.new
  end

  def productnameset
    @productnameset = Productnameset.all
  end

  def productnameset_write_complete
    pro = Productnameset.new
    pro.productname = params[:productname]
    if pro.save
      redirect_to "/productnameset", notice: "정상적으로 저장되었습니다."
    else
      flash[:notice] = pro.errors[:productname][0]
      redirect_to :back
    end
  end

  def productnameset_destroy
    @productnameset = Productnameset.find(params[:id])
    @productnameset.destroy
    redirect_to "/productnameset", notice: "정상적으로 삭제되었습니다."
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def pro_params
      params.require(:product).permit(:pname, :puchase_kg, :release_kg, :stock_kg, :predict, :month_avg, :memo, :created_at, :updated_at, :productnameset_id)
    end

end
