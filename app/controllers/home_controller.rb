class HomeController < ApplicationController

  def index
    cookies.delete(:cookie_name) # 다른페이지에서 인덱스로 돌아왔을 땐 쿠키를 삭제시킴
    @cookies = cookies[:cookie_name]
    @category_list = Category.all # index페이지의 카테고리들을 불러오는 변수를 만듦
  end

  def cookie_rec
    # 쿠키 :cookie_name을 설정(유효기간은 1개월)
    cookies[:cookie_name] = { value: params[:value],
       expires: 3.hours.from_now, http_only: true }
    respond_to do |format|
      format.html { redirect_to '/inventories' }
      format.json { head :no_content }
    end
  end

end
