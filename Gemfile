source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'

gem 'mysql2', '~> 0.5.2'

# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'

gem 'ed25519'
gem 'bcrypt_pbkdf'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
#
# url: https://github.com/doorkeeper-gem/doorkeeper
gem 'doorkeeper'

# For configuration in connfig/setting
gem 'config'

# Auto schema in models, url: https://github.com/ctran/annotate_models
gem 'annotate'

# Better rails console, url: https://github.com/goodpeople/debbie
gem 'debbie', :group => :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'devise'

# https://rubygems.org/gems/active_model_serializers
gem 'active_model_serializers', '~> 0.10.10'

# Active admin, url: https://github.com/activeadmin/activeadmin
gem 'activeadmin'

# Theme
gem 'active_material', github: 'vigetlabs/active_material'
gem 'listen', '~> 3.2'

# Cors for external host, url: https://github.com/cyu/rack-cors
gem 'rack-cors', require: 'rack/cors'

group :development, :test do
	# Call 'byebug' anywhere in the code to stop execution and get a debugger console
	gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

	gem 'shoulda-matchers'
	gem 'rspec-rails'
	gem 'rspec-mocks'
	gem "rubycritic", :require => false
	gem 'sandi_meter' # Static analysis tool for checking Ruby code for Sandi Metz' rules.
	gem 'simplecov'
	gem "factory_bot_rails"
	gem 'rails-controller-testing'
	gem "rails_best_practices"
	gem 'rspectre'

	gem 'rubocop-rspec', require: false
	gem 'rubocop', require: false
	gem 'rubocop-performance'
end

group :development do
	# Access an interactive console on exception pages or by calling 'console' anywhere in the code.
	gem 'web-console', '>= 3.3.0'
	# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
	gem 'spring'
	gem 'spring-watcher-listen', '~> 2.0.0'

	gem 'capistrano', require: false
	gem 'capistrano-rvm', require: false
	gem 'capistrano-rails', require: false
	gem 'capistrano-bundler', require: false
	gem 'capistrano-secrets-yml', require: false
	gem 'capistrano3-puma', github: "seuros/capistrano-puma"

	gem 'brakeman'
	gem 'traceroute'
end

group :test do
	# Adds support for Capybara system testing and selenium driver
	gem 'capybara', '>= 2.15'
	gem 'selenium-webdriver'
	gem 'webmock'
	gem 'cucumber-rails', require: false
	gem 'database_cleaner'
	# Easy installation and use of web drivers to run system tests with browsers
	gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
