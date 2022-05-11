class ProductsController < ApplicationController
	def index
    # debugger
		@products = Product.all
	end

  def new
    #debugger
    @category = Category.find(params[:category_id])
    @product = @category.products.new
  end

  def show
    #debugger
		#@category = Category.find(params[:category_id])
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

  private
  def product_params
    params.permit(:name,:description,:price,:category_id)
  end

end
