require 'simplecov'
require 'webmock/rspec'

SimpleCov.start do
  project_name 'Iflan Ws'
  coverage_dir 'reports/coverage/'

  add_filter 'app/admin'
  add_filter 'app/controllers/application_controller.rb'
  add_filter 'app/helpers/application_helper.rb'
  add_filter 'app/models/ability.rb'

  add_filter 'bin'
  add_filter 'challenge'
  add_filter 'config'
  add_filter 'db'
  add_filter 'key'
  add_filter 'lib'
  add_filter 'log'
  add_filter 'public'
  add_filter 'reports'
  add_filter 'spec'
  add_filter 'vendor'
  add_filter 'reports'

  add_group 'Models', '/app/models'
  add_group 'Controllers', '/app/controllers'
  add_group 'Interactors', '/app/interactors'
  add_group 'Serializers', '/app/serializers'
  add_group 'Services', '/app/services'
  add_group 'Helpers', '/app/helpers'
end

#Testing
require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'shoulda/matchers'

Dir[Rails.root.join('spec/helpers/*.rb')].each { |f| require f }
Dir[Rails.root.join("spec/shared_examples/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/contexts/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include Devise::Test::ControllerHelpers, type: :controller

  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
  config.include Serializers

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

end

