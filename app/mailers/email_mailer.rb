class EmailMailer < ActionMailer::Base

  default :from => "annonymous@#{ENV['SENDGRID_DOMAIN']}"
  
  def send_email(email, code)
    @email = email
    @code = code
    mail(:to => email, :subject => "Anonymous Message") do |format|
      format.text
    end
  end

end