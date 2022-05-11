class ApplicationController < ActionController::Base
	before_action :set_current_user
    def set_current_user
      # finds user with session data and stores it if present
      Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
    end
    
    def require_user_logged_in!
      # allows only logged in user
      redirect_to sign_in_path, alert: 'You must be signed in' if Current.user.nil?
    end

    # def current_shopping_cart
    #   @user = Current.user
    #   role = user.roles.collect(&:name)
    #   if role.include?("Buyer")
    #     # @cart = @user.cart
    #     if session[:cart]
    #       @cart = Cart.find(session[:cart])
    #     else
    #       @cart = Cart.create()
    #       session[:cart] = @cart.id
    #     end
    #   end
    # end

    

end
