class MonthaverageController < ApplicationController
  def yearavg

    
    @inventory = Inventory.group(:iname)
    @monthavg = @inventory.products.group(:created_at).average(:puchase_kg)
    
  end

  def monthavg
  end

  def dailyavg
  end
  
  def create
    @monthaverage = Monthaverage.new(monthaverage_params)

    respond_to do |format|
      if @monthaverage.save
        format.html { redirect_to @monthaverage, notice: 'monthaverage was successfully created.' }
        format.json { render :yearavg, status: :created, location: @monthaverage }
      else
        format.html { render :root }
        format.json { render json: @monthaverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventories/1
  # PATCH/PUT /inventories/1.json
  def update
    respond_to do |format|
      if @monthaverage.update(inventory_params)
        format.html { redirect_to @monthaverage, notice: 'monthaverage was successfully updated.' }
        format.json { render :yearavg, status: :ok, location: @monthaverage }
      else
        format.html { render :root }
        format.json { render json: @monthaverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1
  # DELETE /inventories/1.json
  def destroy
    @monthaverage.destroy
    respond_to do |format|
      format.html { redirect_to inventories_url, notice: 'monthaverage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monthaverage
      @monthaverage = Monthaverage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monthaverage_params
      params.require(:monthaverage).permit(:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december, :year_index)
    end 
end
