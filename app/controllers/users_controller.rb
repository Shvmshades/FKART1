class UsersController < ApplicationController
  before_action :require_user_logged_in!

  # def carts
  #   @user = User.find(Current.user.id)
  #   @cart = @user.cart
  #   #debugger
  #   if @cart.nil?
  #     redirect_to root_path, alert:"you don't have any product in cart"
  #   else
  #     @cartproducts = @cart.products
  #   end
  # end

  def show 
    @user = User.find(Current.user.id)
  end

  def remove_cart_product
    # debugger
    @cart_product = CartProduct.find_by(cart_id: params[:cart_id], product_id: params[:product_id])
    if @cart_product.destroy
      redirect_to carts_path, notice:'product removed successfully'
    end
  end

end
