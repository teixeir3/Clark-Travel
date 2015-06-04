class UserMailer < ActionMailer::Base
  default from: "no-reply@clark-travel.com <Clark Travel Agency>"
  
  def activation_email(user)
    @user = user
    @url = activate_users_url(activation_token: @user.activation_token)
    
    mail(to: "#{user.full_name} <#{user.email}>", subject: 'Welcome to Clark-Travel')
  end
  
  def password_reset_email(user)
    @user = user
    @url = password_reset_users_url(reset_token: @user.activation_token)
    
    mail(to: "#{user.full_name} <#{user.email}>", subject: 'Clark-Travel Password Reset')
  end
  
  def contact_me_email(user, params)
    @user = user
    @params = params
    
    mail(to: "#{user.full_name} <#{user.email}>", subject: 'Clark-Travel.com Inquiry')
  end
  
  def german_cruising_form_email(user, params)
    @user, @params = user, params
    
    mail(to: "#{user.full_name} <#{user.email}>", subject: 'Ted Hierl Registration:')
  end
end
