class MonthaverageController < ApplicationController
    before_action :set_monthaverage, only: []

  def yearavg
    @monthaverages = Monthaverage.all


  end

  def monthavg
    
  end

  def dailyavg
      
  end
  
  private
  
  def set_product
    @monthaverage = Monthaverage.find(params[:id])
  end
  
  def monthavg_params
    params.require(:monthaverage).permit(:inven_name, :january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december,
                 :january_c, :february_c, :march_c, :april_c, :may_c, :june_c, :july_c, :august_c, :september_c, :october_c, :november_c, :decemver_c, :y_index, :m_index)
  end
  
end