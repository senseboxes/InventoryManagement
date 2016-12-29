class IteminfoController < ApplicationController
  def iteminfo_write
  end
  
  def write_complete
    i = Iteminfo.new
    i.name = params[:name]
    i.categoryID = params[:category]
    i.inputID = params[:inputid]
    if i.save
      redirect_to "/iteminfo/setting_page"
    else
      flash[:alert] = '저장되지 않았습니다.'
      redirect_to :back
    end
  end
  
  def setting_page
    @iteminfo = Iteminfo.new(categoryID: '11')
    @iteminfos = Iteminfo.select(:categoryID).distinct
  end
end
