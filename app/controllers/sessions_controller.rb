class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])
    #debugger
    if @user.nil?
      redirect_to root_path, alert:"user email doesn't exist"
    else
      if @user.email_confirmed
        # finds existing user, checks to see if user can be authenticated
        if @user.present? && @user.authenticate(params[:password])# sets up user.id sessions
          session[:user_id] = @user.id
          redirect_to root_path, notice: 'Logged in successfully'
        else
          redirect_to new_session_path, alert:'Invalid email or password' 
        end
      else
        redirect_to root_path, alert:'mail is not verified'
      end
    end
  end
  
  def destroy
    # deletes user session
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged Out'
  end

end
