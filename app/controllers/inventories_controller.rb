class InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show, :edit, :update, :destroy]

  # Public 메소드 시작 ↓↓↓
  # GET /inventories
  # GET /inventories.json
  def index
    @categories = Category.all
    @inventories = Inventory.paginate(:page => params[:page])
#    @inventories = Inventory.order("id DESC")    or @inventories = Inventory.reverse # 역정렬
  end
  
  def index_category
    @categories = Category.all
    
    case params[:category_id]
    when "1"
      @indexcategory = "1"
    when "2"
      @indexcategory = "2"
    when "3"
      @indexcategory = "3"
    end
    @inventories = Inventory.where(category_id: params[:category_id])
    @inventories = @inventories.paginate(:page => params[:page])
  end
  
  def setting_page
    @inventories = Inventory.paginate(:page => params[:page]).order("id DESC")
  end
  
  def category_write
    
  end
  
  def category_write_complete
    c = Category.new
    c.name = params[:categoryname]
    if c.save
      redirect_to "/categories"
    else
      flash[:alert] = c.errors[:categoryname][0]
      redirect_to :back
    end
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
        format.html { redirect_to '/setting_page', notice: '재고을 저장 하였습니다.' }
        format.json { render :show, status: :created, location: @inventory }
      else
        format.html { render :new }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
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
      params.require(:inventory).permit(:iname, :inputID, :categoryID, :text, :category_id)
    end
    
    # 보조 & 필터 메소드 끝 ↑↑↑
end
