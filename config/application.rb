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

    config.autoload_paths += Dir[Rails.root.join('app', 'interactors', '{*/}')]
    config.autoload_paths += Dir[Rails.root.join('app', 'services', '{*/}')]
  end
end
