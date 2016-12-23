class MonthaverageController < ApplicationController
    before_action :set_monthaverage, only: []
    
  def yearavg
    @monthaverages = Monthaverage.all

  end

  def monthavg
    
  end

  def dailyavg
      
  end
  
end