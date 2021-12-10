class UserMailer < ApplicationMailer
  default from: 'playbox.thp@gmail.com'
 
  def welcome_email(user)
    @user = user 
    @url  = 'https://playbox-info.herokuapp.com/connexion'

    mail(to: @user.email, subject: 'Bienvenue chez nous !')
  end
end
