class UserMailer < ActionMailer::Base
  def confirm_follow(mail)
    mail(:to => mail, :subject => "#{current_user.full_name} is following you")
  end  
end
