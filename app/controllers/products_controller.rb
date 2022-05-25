class ProductsController < ApplicationController
	
  def index
    @categories = Category.all
		@products = Product.all
	end

  def search
    if params[:search].blank?
      redirect_to root_path, alert:'there is no product you want'
    else
      @prod = params[:search]
      @products = Product.search("#{@prod}", page: params[:page], per_page: 20)
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
    debugger
    @category = Category.find(params[:category_id])
    @product = @category.products.new(product_params)
    @category.products << @product
    if @product.save
      #@product.reindex
      redirect_to seller_product_path, notice:'product added successfully'
    else
      
      redirect_to new_category_product_path, alert:"field can't be empty"
    end
  end

  def edit
    #debugger
    @category = Category.find(params[:category_id])
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to seller_product_path, notice:'product has been updated'
    else
      redirect_to seller_product_path, alert:"something is wrong"
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
