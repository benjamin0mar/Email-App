require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MyEmailApp
  class Application < Rails::Application

    config.autoload_paths += %W(#{config.root}/lib/workers)
    config.eager_load_paths += %W(#{config.root}/lib/workers)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.

    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.perform_deliveries = true
    #
    # ActionMailer::Base.smtp_settings = {
    #   :address              => "smtp.gmail.com",
    #   :port                 => "587",
    #   :domain               => 'gmail.com',
    #   :user_name            => 'benjaminomar34@gmail.com',
    #   :password             => 'codigo34',
    #   :authentication       => 'plain',
    #   :enable_starttls_auto => true  }
    # config.active_record.raise_in_transactional_callbacks = true

    ActionMailer::Base.smtp_settings = {
      :address => "smtp.sendgrid.net",
      :port => 25,
      :domain => "omarbenjamin.com",
      :authentication => :plain,
      :user_name => "benjamin0mar",
      :password => "codigo34"
    }

  end
end
