if Rails.env == 'test' or Rails.env == 'development'
	require 'rubycritic/cli/application'

	namespace :app do
		desc 'Automatic code-review report'
		task :codereview do
			arguments = ['--no-browser', '--path', 'reports/codereview', 'app', 'lib']
			app = RubyCritic::Cli::Application.new arguments
			app.execute
		end
	end
end
