class RegistrationsController < ApplicationController
  
  def new
    @user = User.new
  end

  def show
  end
  
  def show_user
    @user = User.find(Current.user.id)
  end

    
  def create
    @user = User.new(user_params)
    if @user.save
        # stores saved user id in a session  
      UserMailer.with(user: @user).registration_confirmation.deliver_now
      #session[:user_id] = @user.id
      redirect_to root_path, notice:'please confirm your email to continue'
    else
      redirect_to root_path, alert:'user is not saved.'
    end
  end

  def update_token
    #debugger
    @user = User.find_by(id: params[:id])
    if @user.update(confirm_token:SecureRandom.urlsafe_base64.to_s)
      UserMailer.with(user: @user).registration_confirmation.deliver_now
      redirect_to root_path, notice:'please confirm your email to continue'
    else
      redirect_to root_path, alert:'something is wrong'
    end
  end
    
  def confirm_email
    @user = User.find_by_confirm_token(params[:id])
    if @user
      #debugger
      if @user.updated_at + 15.minutes >= Time.zone.now
        @user.email_activate
        flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
        Please sign in to continue."
        redirect_to new_session_path, notice:'welcome to fkart'
      else
        redirect_to registration_path(id: @user.id),notice:'your link has been expired'
      end
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
  end

  private
  def user_params
    # strong parameters
    params.require(:user).permit(:email,:name, :password, :password_confirmation)
  end
end