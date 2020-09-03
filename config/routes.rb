Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'admin/users#index'
  get '/admin', to: 'admin/users#index', as: '/admin'

end
