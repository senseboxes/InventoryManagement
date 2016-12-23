class Monthaverage < ApplicationRecord
  belongs_to :inventory  
  
  def initialize
   params.require(:monthaverage).permit(:inven_name, :january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december,
             :january_c, :february_c, :march_c, :april_c, :may_c, :june_c, :july_c, :august_c, :september_c, :october_c, :november_c, :decemver_c, :y_sum, :y_avg, :m_avg, :y_index, :m_index)
             
   params[:january] = 0
   params[:february] = 0
   params[:march] = 0
   params[:april] = 0
   params[:may] = 0
   params[:june] = 0
   params[:july] = 0
   params[:august] = 0
   params[:september] = 0
   params[:october] = 0
   params[:november] = 0
   params[:december] =  0
   params[:january_c] = 0
   params[:february_c] = 0
   params[:march_c] = 0
   params[:april_c] = 0
   params[:may_c] = 0
   params[:june_c] = 0
   params[:july_c] = 0
   params[:august_c] = 0
   params[:september_c] = 0
   params[:october_c] = 0
   params[:november_c] = 0
   params[:december_c] =  0
   params[:y_sum] =  0
   params[:y_avg] =  0
   params[:m_avg] =  0
   end
end
