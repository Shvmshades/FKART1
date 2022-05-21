class ApplicationController < ActionController::Base
	before_action :set_current_user
  # before_action :delete_obsolete_data
    def set_current_user
      # finds user with session data and stores it if present
      Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
    end
    
    def require_user_logged_in!
      # allows only logged in user
      redirect_to new_session_path, alert: 'You must be signed in' if Current.user.nil?
    end


    # def delete_obsolete_data
    #   @user = User.where(created_at: 30.days.ago..10.days.ago)
    #   @user.each {|f| User.destroy(f.id)}
    # end

end
