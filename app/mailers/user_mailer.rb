class UserMailer < ActionMailer::Base
  default :from => "shane@homebrewster.com"

  def expire_email(user)
    mail(:to => user.email, :subject => "Subscription Cancelled")
  end

  def signup_email(user)
    mail(:to => user.email, :subject => "Thanks for signing up!")
  end

end
