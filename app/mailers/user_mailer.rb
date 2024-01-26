class UserMailer < ApplicationMailer
  def set_a_password(user, token)
    @user = user
    @link = edit_user_password_url(reset_password_token: token)
    mail(to: @user.email, subject: 'Set a Password')
  end
end
