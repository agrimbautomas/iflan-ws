lock "~> 3.14.1"

set :application, 'iflan-ws'
set :repo_url, 'git@gitlab.com:i-flan/iflan-ws.git'

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'key', 'certificates', 'challenge')

set :keep_releases, 2
set :rvm_ruby_version, '2.7.1'
set :puma_init_active_record, true