require_relative "boot"

require "rails/all"

require 'dotenv'
Dotenv.load('config.env')

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Heart
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address => 'smtp.163.com',
      :domain => 'mail.163.com',
      :port => 25,
      :enable_starttls_auto => true,
      :authentication => :plain,
      :user_name => ENV["SMTP_MAIL_USERNAME"],
      :password => ENV["SMTP_MAIL_PASSWORD"],
    }

    # Logger ####################
    # config.lograge.enabled = Settings[:lograge][:enabled] # logger记录新方式 true/false
    # config.lograge.keep_original_rails_log = Settings[:lograge][:keep_original] # logger记录旧方式 true/false
  end
end

require 'string_utils'
require 'number_utils'
require 'hash_utils'
