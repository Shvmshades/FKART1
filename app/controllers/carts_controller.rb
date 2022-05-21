class CartsController < ApplicationController
  before_action :require_user_logged_in!

  # def index
  #   @user = User.find(Current.user.id)
  # end

  def user_carts
    @user = User.find(Current.user.id)
    @cart = @user.cart
    #debugger
    if @cart.nil?
      redirect_to root_path, alert:"you don't have any product in cart"
    else
      @cartproducts = @cart.products
    end
  end


  def create
    @user = User.find(Current.user.id)#debugger
    if Cart.find_by(user_id: @user.id)
      # debugger
      cart_product
    else
      @cart = @user.build_cart(cart_params)
      if @cart.save
        #debugger
        cart_product
      else
        redirect_to root_path, alert:'cart is not created'
      end
    end
  end

  def destroy
  end

  
  def cart_product
    @user = User.find(Current.user.id)
    @cart = Cart.find_by(user_id: @user.id)
   #debugger
    cart_prod = CartProduct.new(cart_id: @cart.id,product_id: params[:product_id])
    if cart_prod.save
      redirect_to carts_path, notice:'added to the cart'
    else
      redirect_to carts_path, alert:'something is wrong'
    end
  end

  def remove_cart_product
    # debugger
    @cart_product = CartProduct.find_by(cart_id: params[:cart_id], product_id: params[:product_id])
    if @cart_product.destroy
      redirect_to carts_path, notice:'product removed successfully'
    end
  end



  private

  def cart_params
    params.permit(:product_id)
  end
end
