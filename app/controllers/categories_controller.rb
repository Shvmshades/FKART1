class CategoriesController < ApplicationController
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def product_by_category
    @category = Category.find(params[:id])
    #debugger
    @products = @category.products
    #@products = Product.all.where(category_id:@cat_id)
  end

  def create
    @category = Category.new(name: params[:name])
    if @category.name.blank?
      redirect_to new_category_path, alert:"category name can't be blank"
    else
      if @category.save
      redirect_to categories_path, notice:'category added successfully'
      else
        redirect_to new_category_path, alert:'something is wrong'
      end
    end
  end

end
