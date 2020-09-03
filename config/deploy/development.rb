role :app, %w{deploy@api.iflan.house}
role :web, %w{deploy@api.iflan.house}
role :db, %w{deploy@api.iflan.house}

set :deploy_to, '/srv/rails/iflan-ws'

server 'api.iflan.house', user: 'deploy', roles: %w{web app}

set :rails_env, 'development'
set :branch, 'master'

#after 'deploy', 'sitemap:refresh'