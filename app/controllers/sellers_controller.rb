class SellersController < ApplicationController
  before_action :require_user_logged_in!

  def set_seller
    @user = User.find(Current.user.id)
    #debugger
    #user = @user.roles.new(name:"Seller")
    if @user.roles.create(name:"Seller")
      redirect_to root_path, notice:"now #{@user.name} becomes seller!"
    else
      redirect_to root_path, alert:'something is wrong'
    end
  end

  def new
    @product = Product.new()
  end
end
