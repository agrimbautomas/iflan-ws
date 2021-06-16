role :app, %w{deploy@iflan.api.lazlo.boutique}
role :web, %w{deploy@iflan.api.lazlo.boutique}
role :db, %w{deploy@iflan.api.lazlo.boutique}

set :deploy_to, '/srv/rails/iflan-ws'

server 'iflan.api.lazlo.boutique', user: 'deploy', roles: %w{web app}

set :rails_env, 'development'
set :branch, 'master'

#after 'deploy', 'sitemap:refresh'