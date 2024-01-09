Rails.application.configure do
  config.action_mailer.delivery_method = Settings[:mailer][:delivery_method]
  config.action_mailer.smtp_settings = {
    :address => Settings[:mailer][:address],
    :domain => Settings[:mailer][:domain],
    :port => Settings[:mailer][:port],
    :enable_starttls_auto => Settings[:mailer][:enable_starttls_auto],
    :authentication => Settings[:mailer][:authentication],
    :user_name => ENV["SMTP_MAIL_USERNAME"],
    :password => ENV["SMTP_MAIL_PASSWORD"],
  }
  config.action_mailer.logger = ActiveSupport::Logger.new("log/mailer.log")
end