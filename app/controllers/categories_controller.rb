class CategoriesController < ApplicationController
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  # def show
  #   @category = Category.find(params[:id])
  #   @products = @category.products.all
  # end

  def create
    @category = Category.new(name: params[:name])
    if @category.save
      redirect_to categories_path, notice:'category added successfully'
    else
      redirect_to new_category_path, alert:'something is wrong'
    end
  end

end
