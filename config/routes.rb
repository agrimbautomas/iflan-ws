Rails.application.routes.draw do
	use_doorkeeper
	devise_for :users, ActiveAdmin::Devise.config
	ActiveAdmin.routes(self)

	root to: 'admin/noise_logs#index'
	get '/admin', to: 'admin/noise_logs#index', as: '/admin'

	scope module: 'api' do
		scope '1', module: 'v1' do

      resources :tmp_hum_logs
      resources :noise_logs

		end
	end
end
