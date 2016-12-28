require 'time'

class MonthaverageController < ApplicationController
    before_action :set_monthaverage, only: []

@@user_time = 0

def set_usertime(utime)
  @@user_time = utime
end

  # 새로운 함수 호출
  # 월 합산o, 월 사용 카운트[월에 몇번을 생산했는지 카운트 기록], 월평균 사용량o, 회당 평균 사용량, 년합산o
  def sum_monthavg(pro_params, recent_proparams)  #recent_proparams = @recentdata
    
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
    @monthaverages.save
    avg_sum_year(@monthaverages)
  end
  
  def avg_sum_year(month_avg_sum)
    month_avg_sum[:y_sum] =  month_avg_sum[:january] + month_avg_sum[:february] + month_avg_sum[:march] + month_avg_sum[:april] + month_avg_sum[:may] + month_avg_sum[:june] + month_avg_sum[:july] + month_avg_sum[:august] + month_avg_sum[:september] + month_avg_sum[:october] + month_avg_sum[:november] + month_avg_sum[:december]
    month_avg_sum[:y_avg] = month_avg_sum[:y_sum] / 12
    @monthaverages = month_avg_sum
    @monthaverages.save
  end
  
  def listsall
    @monthaverages = Monthaverage.all
  end
    
  def yearavg # 처음 연 평균 페이지를 monthaverage 리스트가 뜬다.
    
  end
  
  def years_category # 연도를 선택하면 해당 연도의 사용량 통계만 볼 수 있다.
    case params[:category]
    when "2015"
      @category = "2015"
    when "2016"
      @category = "2016"
    when "2017"
      @category = "2017"
    end
    @monthaverages = Monthaverage.where(y_index: @category)
  end

  def monthavg # 가장 최근 연도의 사용량 통계만 표시 예) 지금이 2016년이면 2016년의 자료만 출력 .... 17년이면 17년의 자료만 출력
    now_year = Time.new    
    @yeardroplist = Monthaverage.where(y_index: now_year.year)
  end

  def dailyavg
      
  end    
   
    def month_params
      params.require(:monthaverage).permit(:inven_name, :january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december,
               :january_c, :february_c, :march_c, :april_c, :may_c, :june_c, :july_c, :august_c, :september_c, :october_c, :november_c, :decemver_c, :y_sum, :y_avg, :m_avg, :y_index, :m_index)
    end
    
    
  
end