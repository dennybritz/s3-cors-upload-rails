class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to root_path, :notice => "Upload was successful."
    else
      render :new
    end
    
  end

end
