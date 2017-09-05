class ProductnamesetController < ApplicationController

  def create
    @productnameset = Productnameset.new(productnameset_params)
    if @productnameset.save
      render json: @productnameset
    else
      render json: {errors: @productnameset.errors.full_messages}
    end
  end

  private

    def productnameset_params
      params.require(:productnameset).permit(:productname, :description)
    end
end
