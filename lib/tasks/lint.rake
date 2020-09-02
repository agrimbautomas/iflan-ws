if Rails.env.development? or Rails.env.test?

  require 'rubocop/rake_task'

  namespace :app do
    desc 'Code style and syntax issues report generator'
    RuboCop::RakeTask.new :lint do |task|
      task.requires = ['rubocop-rspec', 'rubocop-performance']
      task.formatters = ['html']
      task.fail_on_error = false
      task.options = ['-c.rubocop.yml', '-oreports/lint.html']
    end
  end

end