require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Iflan
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.time_zone = 'America/Argentina/Buenos_Aires'
    config.i18n.default_locale = :es

    config.autoload_paths += Dir[Rails.root.join("app", "interactors", "{*/}")]
    config.autoload_paths += Dir[Rails.root.join("app", "models", "{*/}")]
    config.autoload_paths += Dir[Rails.root.join("app", "repositories", "{*/}")]
    config.autoload_paths += Dir[Rails.root.join("app", "serializers", "{*/}")]
    config.autoload_paths += Dir[Rails.root.join("app", "services", "{*/}")]


    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins Rails.application.secrets.allowed_origins
        resource '*', headers: :any, methods: [:get, :post, :options, :put, :patch, :delete]
      end
    end
  end
end
