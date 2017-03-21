require 'time'
class MonthaverageController < ApplicationController
    before_action :set_monthaverage, only: []

@@user_time = 0

  def set_usertime(utime)
    @@user_time = utime
  end

  # 새로운 함수 호출
  # 월 합산o, 월 사용 카운트[월에 몇번을 생산했는지 카운트 기록], 월평균 사용량o, 회당 평균 사용량, 년합산o
  def sum_monthavg(pro_params, recent_proparams, inventory_inf)  #recent_proparams = @recentdata

     @inventory = Inventory.find(pro_params[:inventory_id])
     @lastdata = @inventory.products.last

#    time = recent_proparams[:created_at]
     @monthaverages = Monthaverage.find_by(inventory_id: recent_proparams[:inventory_id], y_index: @@user_time.year ) # inventor_id = 1이면서 현재 연 필드 불러오기
    #fine_by 검색에 실패했을 경우
    if ( @monthaverages == nil )
      @monthaverages = Monthaverage.new
      @monthaverages.init_value

      @monthaverages[:inventory_id] = @inventory[:id]
      @monthaverages[:inven_name] = @inventory[:iname]
      @monthaverages.save(:validate => false)  #  (:validate => false)는 검증을 예외처리

      @monthaverages[:inventory_id] = recent_proparams[:inventory_id]     # ID 셋팅하고
      @monthaverages[:y_index] = @@user_time.year                                        # 년도 셋팅한다.
      @monthaverages[:m_index] = @@user_time.month
      @monthaverages[:cat_ID] = inventory_inf[:category_id] #쿠키 사용을 위해 카테고리 아이디를 넣음
    end

    case @@user_time.month
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
    avg_sum_year(@monthaverages)
  end

  def avg_sum_year(month_avg_sum)
    month_avg_sum[:y_sum] =  month_avg_sum[:january] + month_avg_sum[:february] + month_avg_sum[:march] + month_avg_sum[:april] + month_avg_sum[:may] + month_avg_sum[:june] + month_avg_sum[:july] + month_avg_sum[:august] + month_avg_sum[:september] + month_avg_sum[:october] + month_avg_sum[:november] + month_avg_sum[:december]
    month_avg_sum[:y_avg] = month_avg_sum[:y_sum] / 12
    @monthaverages = month_avg_sum
    @monthaverages.save
  end

  def years_category # 연도를 선택하면 해당 연도의 사용량 통계만 볼 수 있다.
    @years_categories = Monthaverage.select(:y_index).distinct.order("y_index DESC")

    if cookies[:cookie_name] == 'fiber'
      @category_id = '1'
    elsif cookies[:cookie_name] == 'grind'
      @category_id = '2'
    elsif cookies[:cookie_name] == nil
      flash[:notice] = "초기화면으로 돌아가 화이버 또는 연마사를 선택하시면 선택한 분류만 볼 수 있습니다."
      @category_id ='1', '2'
    end
    @year_sort = Monthaverage.where(y_index: params[:y_index], cat_ID: @category_id)
    @year_title = params[:y_index]


  end

  def monthavg # 가장 최근 연도의 사용량 통계만 표시 예) 지금이 2016년이면 2016년의 자료만 출력 .... 17년이면 17년의 자료만 출력
    now_year = Time.new

    if cookies[:cookie_name] == 'fiber'
      @category_id = '1'
    elsif cookies[:cookie_name] == 'grind'
      @category_id = '2'
    elsif cookies[:cookie_name] == nil
      flash[:notice] = "초기화면으로 돌아가 화이버 또는 연마사를 선택하시면 선택한 분류만 볼 수 있습니다."
      @category_id ='1', '2'
    end
    @years_categories = Monthaverage.select(:y_index).distinct.order("y_index DESC")
    @years_avglist = Monthaverage.where(y_index: now_year.year)
    @yeardroplist = @years_avglist.where(cat_ID: @category_id)
    @year_title1 = now_year.year

  end

  def month_destroy(inventory_id, month)
    @monthaverages = Monthaverage.find_by(inventory_id: inventory_id)

    if(month != 0)
      @monthaverages = Monthaverage.find_by(m_index: month)
      if(@monthaverages != nil)
          @monthaverages.destroy
      end
    else
      while @monthaverages != nil
        @monthaverages = Monthaverage.find(@monthaverages[:id])
        if(@monthaverages != nil)
          @monthaverages.destroy
          @monthaverages = Monthaverage.find_by(inventory_id: inventory_id)
        end
      end
    end
  end

  def month_minus(pro_info)
    pro_invenID = pro_info[:inventory_id]
    pro_year = pro_info[:created_at].year
    pro_month = pro_info[:created_at].month

    @monthaverages = Monthaverage.find_by(inventory_id: pro_invenID, y_index: pro_year)

    case pro_month
    when 1
      @monthaverages[:january] -= pro_info[:release_kg]
      @monthaverages[:january_c] -= 1
    when 2
      @monthaverages[:february] -= pro_info[:release_kg]
      @monthaverages[:february_c] -= 1
    when 3
      @monthaverages[:march] -= pro_info[:release_kg]
      @monthaverages[:march_c] -= 1
    when 4
      @monthaverages[:april] -= pro_info[:release_kg]
      @monthaverages[:april_c] -= 1
    when 5
      @monthaverages[:may] -= pro_info[:release_kg]
      @monthaverages[:may_c] -= 1
    when 6
      @monthaverages[:june] -= pro_info[:release_kg]
      @monthaverages[:june_c] -= 1
    when 7
      @monthaverages[:july] -= pro_info[:release_kg]
      @monthaverages[:july_c] -= 1
    when 8
      @monthaverages[:august] -= pro_info[:release_kg]
      @monthaverages[:august_c] -= 1
    when 9
      @monthaverages[:september] = pro_info[:release_kg]
      @monthaverages[:september_c] -= 1
    when 10
      @monthaverages[:october] -= pro_info[:release_kg]
      @monthaverages[:october_c] -= 1
    when 11
      @monthaverages[:november] -= pro_info[:release_kg]
      @monthaverages[:november_c] -= 1
    when 12
      @monthaverages[:december] -= pro_info[:release_kg]
      @monthaverages[:december_c] -= 1
    end
    avg_sum_year(@monthaverages)

    # 연 합계가 0일 경우 해당 리스트를 삭제한다
    if @monthaverages[:y_sum].zero?
      month_destroy(pro_info[:inventory_id], pro_month)
    end
#    count_zero_destroy(@monthaverages[:y_avg])
  end

  def import_sum_monthavg(product)  #recent_proparams = @recentdata

     @inventory = Inventory.find(product["inventory_id"])
     @lastdata = @inventory.products.last

  #    time = recent_proparams[:created_at]
     @monthaverages = Monthaverage.find_by(inventory_id: product["inventory_id"], y_index: product["created_at"].year ) # inventor_id = 1이면서 현재 연 필드 불러오기
    #fine_by 검색에 실패했을 경우
    if ( @monthaverages == nil )
      @monthaverages = Monthaverage.new
      @monthaverages.init_value

      @monthaverages[:inventory_id] = @inventory[:id]
      @monthaverages[:inven_name] = @inventory[:iname]
      @monthaverages.save(:validate => false)  #  (:validate => false)는 검증을 예외처리

      @monthaverages[:inventory_id] = product["inventory_id"]     # ID 셋팅하고
      @monthaverages[:y_index] = product["created_at"].year                                        # 년도 셋팅한다.
      @monthaverages[:m_index] = product["created_at"].month
    end

    case product["created_at"].month
    when 1
      @monthaverages[:january] += product["release_kg"]
      @monthaverages[:january_c] += 1
    when 2
      @monthaverages[:february] += product["release_kg"]
      @monthaverages[:february_c] += 1
    when 3
      @monthaverages[:march] += product["release_kg"]
      @monthaverages[:march_c] += 1
    when 4
      @monthaverages[:april] += product["release_kg"]
      @monthaverages[:april_c] += 1
    when 5
      @monthaverages[:may] += product["release_kg"]
      @monthaverages[:may_c] += 1
    when 6
      @monthaverages[:june] += product["release_kg"]
      @monthaverages[:june_c] += 1
    when 7
      @monthaverages[:july] += product["release_kg"]
      @monthaverages[:july_c] += 1
    when 8
      @monthaverages[:august] += product["release_kg"]
      @monthaverages[:august_c] += 1
    when 9
      @monthaverages[:september] += product["release_kg"]
      @monthaverages[:september_c] += 1
    when 10
      @monthaverages[:october] += product["release_kg"]
      @monthaverages[:october_c] += 1
    when 11
      @monthaverages[:november] += product["release_kg"]
      @monthaverages[:november_c] += 1
    when 12
      @monthaverages[:december] += product["release_kg"]
      @monthaverages[:december_c] += 1
    end
    avg_sum_year(@monthaverages)
  end

  def yearavg

  end

  def dailyavg

  end

  def month_params
    params.require(:monthaverage).permit(:inven_name, :inventory_id, :january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december,
             :january_c, :february_c, :march_c, :april_c, :may_c, :june_c, :july_c, :august_c, :september_c, :october_c, :november_c, :decemver_c, :y_sum, :y_avg, :m_avg, :y_index, :m_index, :cat_ID)
  end



end
