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
    @user = User.find(Current.user.id)
    if @product = @user.products.create(product_params)
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
    params.permit(:name,:description,:price,:category_id,:image,:search)
  end

end
