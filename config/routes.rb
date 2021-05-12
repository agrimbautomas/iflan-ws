Rails.application.routes.draw do
  use_doorkeeper
	use_doorkeeper
	devise_for :users, ActiveAdmin::Devise.config
	ActiveAdmin.routes(self)

	root to: 'admin/tmp_hum_logs#index'
	get '/admin', to: 'admin/tmp_hum_logs#index', as: '/admin'

	scope module: 'api' do
		scope '1', module: 'v1' do

			get 'stats', to: 'stats#index'

      resources :tmp_hum_logs
      resources :noise_logs

			devise_for :users, controllers: {
				registrations: 'api/v1/users/registrations',
			}, skip: [:sessions, :password]

		end
	end
end
