class ProdNamelistsController < ApplicationController
  def create
    @prod_namelist = ProdNamelist.new(prod_namelist_params)
    if @prod_namelist.save
      render json: @prod_namelist
    else
      render json: {errors: @prod_namelist.errors.full_messages}
    end
  end

  private

    def prod_namelist_params
      params.require(:prod_namelist).permit(:name, :description)
    end
end
