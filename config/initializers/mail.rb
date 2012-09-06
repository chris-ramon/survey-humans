ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "gmail.com",
  :user_name => "rails.dummy.mailer@gmail.com",
  :password => "123dummy456",
  :authentication => :login,
  :enable_starttls_auto => true
}
