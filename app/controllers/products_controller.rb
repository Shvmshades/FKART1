class ProductsController < ApplicationController
	
  def index
		@products = Product.all
	end

  def search
    if params[:search].blank?
      redirect_to root_path, alert:'there is no product you want'
    else
      #debugger
      @prod = params[:search]
      @products = Product.all.where("name LIKE ?", "%#{@prod}%")
      if @products.blank?
        redirect_to root_path, alert:'there is no product you want'
      end
    end
  end

  def new
    @category = Category.find(params[:category_id])
    @product = @category.products.new
  end

  def show
    @product = Product.find(params[:id])
  end


  def create
    #debugger
    @category = Category.find(params[:category_id])
    if @product = @category.products.create(product_params)
      redirect_to seller_product_path, notice:'product added successfully'
    else
      redirect_to new_category_product_path, alert:'something is wrong'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to seller_product_path, notice:'product has been deleted'
    else
      redirect_to seller_product_path, alert:'something is wrong'
    end
  end


  private
  def product_params
    params.permit(:name,:description,:price,:user_id,:category_id,:image,:search,:quantity)
  end

end
