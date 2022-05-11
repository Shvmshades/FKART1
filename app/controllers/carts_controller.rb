class CartsController < ApplicationController
  before_action :require_user_logged_in!

  # def index
  #   @user = User.find(Current.user.id)
  # end

  def create
    @user = User.find(Current.user.id)#debugger
    if Cart.find_by(params[:user_id])
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
    @cart = Cart.find_by(params[:user_id])
   #debugger
    cart_prod = CartProduct.new(cart_id: @cart.id,product_id: params[:product_id])
    if cart_prod.save
      redirect_to carts_path, notice:'added to the cart'
    else
      redirect_to carts_path, alert:'something is wrong'
    end
  end


  private

  def cart_params
    params.permit(:product_id)
  end
end
