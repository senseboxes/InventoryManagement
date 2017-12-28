class HomeController < ApplicationController

  def index
    cookies.delete(:cookie_name)
    @category_list = Category.all
  end

  def cookie

  end

  def cookie_rec
    # 쿠키 :cookie_name을 설정(유효기간은 1개월)
    cookies[:cookie_name] = { value: params[:cookie_name],
       expires: 1.months.from_now, http_only: true }
    respond_to do |format|
      format.html { redirect_to '/inventories' }
      format.json { head :no_content }
    end
  end

end
