class InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show, :edit, :update, :destroy]

  # Public 메소드 시작 ↓↓↓
  # GET /inventories
  # GET /inventories.json
  def index
    @categories = Category.all
      if cookies[:cookie_name] == 'fiber'
        @category_id = '1'
      elsif cookies[:cookie_name] == 'grind'
        @category_id = '2'
      elsif cookies[:cookie_name] == nil
        flash[:notice] = "초기화면으로 돌아가 화이버 또는 연마사를 선택하시면 선택한 분류만 볼 수 있습니다."
        @category_id ='1', '2'
      end
      @inventories = Inventory.where(category_id: @category_id)
      @inventories = @inventories.paginate(:page => params[:page]).order("id DESC")
  end

  def index_category
    @categories = Category.all
    @inventories = Inventory.where(category_id: params[:category_id])
    @categories_title = @categories.find_by(id: params[:category_id]).name
    @inventories = @inventories.paginate(:page => params[:page]).order("id ASC")
  end

  def setting_page
    @categories = Category.all
    @inventories = Inventory.paginate(:page => params[:page]).order("id DESC")
  end

  def setting_category
    @categories = Category.all
    @inventories = Inventory.where(category_id: params[:category_id])
    @categories_title = @categories.find_by(id: params[:category_id]).name
    @inventories = @inventories.paginate(:page => params[:page]).order("id ASC")
  end

  def category_write_complete
    c = Category.new
    c.name = params[:categoryname]
    if c.save
      redirect_to "/categories", notice: "정상적으로 저장 되었습니다."
    else
      flash[:alert] = c.errors[:categoryname][0]
      redirect_to :back
    end
  end

  def  category_destroy
    @categories = Category.find(params[:id])
    @categories.destroy
    redirect_to "/categories", notice: "정상적으로 삭제 되었습니다."
  end

  def categories
    @categories = Category.all
  end

  # GET /inventories/1
  # GET /inventories/1.json
  def show
    @inventory = Inventory.find(params[:id])
    @products = @inventory.products.paginate(:page => params[:page]).order("id DESC")

  end

  # GET /inventories/new
  def new
    @inventory = Inventory.new
    @product = Product.new
  end

  # GET /inventories/1/edit
  def edit
  end

  # POST /inventories
  # POST /inventories.json
  def create
    @inventory = Inventory.new(inventory_params)

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to '/setting_page', notice: '재고를 저장 하였습니다.' }
        format.json { render :show, status: :created, location: @inventory }
      else
        format.html { render :new }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  def stock_Sum(now_stock)
    @inventories = Inventory.find_by(id: now_stock[:inventory_id])
    @inventories[:iST_KG] = 0
    @inventories[:iST_KG] = now_stock[:stock_kg]
    @inventories.save
  end

  # PATCH/PUT /inventories/1
  # PATCH/PUT /inventories/1.json
  def update
    respond_to do |format|
      if @inventory.update(inventory_params)
        format.html { redirect_to '/setting_page', notice: '재고를 수정하였습니다.' }
        format.json { render :show, status: :ok, location: @inventory }
      else
        format.html { render :edit }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1
  # DELETE /inventories/1.json

  def destroy
    @inventory.destroy
    @MonthaverageController = MonthaverageController.new
    @MonthaverageController.month_destroy(@inventory[:id], 0)
    respond_to do |format|
      format.html { redirect_to setting_page_url, notice: '재고가 삭제되었습니다.' }
      format.json { head :no_content }
    end
  end
  # Public 메소드 끝 ↑↑↑
  private # 보조 메소드 & 필터 시작  ↓↓↓

    # Use callbacks to share common setup or constraints between actions.
    def set_inventory
      @inventory = Inventory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventory_params
      params.require(:inventory).permit(:iname, :inputID, :categoryID, :text, :category_id, :iSK_KG)
    end

    # 보조 & 필터 메소드 끝 ↑↑↑
end
