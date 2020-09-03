namespace :iflan do
	desc 'Automatic code-review report'
	task :codereview do
		require 'rubycritic/cli/application'
		
		arguments = [ '--path', 'reports/codereview', '--no-browser', 'app' ]
		app = RubyCritic::Cli::Application.new arguments
		app.execute
	end
end