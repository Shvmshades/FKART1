class CategoriesController < ApplicationController
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def product_by_category
    @cat_id = params[:id].to_i
    @products = Product.all.where(category_id:@cat_id)
  end

  def create
    @category = Category.new(name: params[:name])
    if @category.save
      redirect_to categories_path, notice:'category added successfully'
    else
      redirect_to new_category_path, alert:'something is wrong'
    end
  end

end
