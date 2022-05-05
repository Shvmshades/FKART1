class ProductsController < ApplicationController
	def index
		@products = Product.all
		#debugger
	end

	def show
		@product = Product.find(params[:id])
	end

end
