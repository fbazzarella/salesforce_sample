NewApp::Application.routes.draw do
  root to: 'users#index'

  devise_for :users

  resources :users, only: :index

  get    '/auth/:provider/callback', to: 'users#omniauth_callback', as: :omniauth_callback
  get    '/auth/failure',            to: 'users#omniauth_failure',  as: :omniauth_failure
  delete '/auth',                    to: 'users#omniauth_destroy',  as: :omniauth_destroy
end
