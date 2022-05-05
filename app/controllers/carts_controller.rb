class CartsController < ApplicationController
  before_action :require_user_logged_in!

  def index
    @user = User.find(Current.user.id)
    #debugger
    @cart_products = @user.products
  end

  def create
    @user = User.find(Current.user.id)
    @cart = @user.carts.new(cart_params)

    if @cart.save
      redirect_to product_carts_path, notice: 'product added to card'
    else
      redirect_to root_path, notice: 'product is not added to cart'
    end
  end

  def destroy
  end

  private

  def cart_params
    params.permit(:user_id,:product_id)
  end
end
