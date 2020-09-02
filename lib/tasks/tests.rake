namespace :app do
	desc 'Run all tests in spec directory'
	task :test do
		Rake::Task[ 'spec' ].invoke
	end

	desc 'Generate code coverage report from tests'
	task :coverage do
		ENV[ 'COVERAGE' ] = 'YES'
		Rake::Task[ 'spec' ].invoke
	end
end
