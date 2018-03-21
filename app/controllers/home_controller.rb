class HomeController < ApplicationController

  def index
    @category_list = Category.all # index페이지의 카테고리들을 불러오는 변수를 만듦
  end

end
