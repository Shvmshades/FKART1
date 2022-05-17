class UserMailer < ApplicationMailer
  default from: 'im.shivamrohilla@gmail.com'

  def registration_confirmation
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Fkart Site')
  end
end
