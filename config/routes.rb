Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#root'
  get '/logout', to: 'sessions#logout', as: 'logout'
  post '/alphavantage', to: 'accounts#alphavantage', as: 'api'
  post '/alpharesp', to: 'accounts#alpharesp', as: 'api_resp'
  get '/stocks', to: 'accounts#stocks', as: 'acc_stocks'
  get '/transactions', to: 'accounts#transactions', as: 'acc_trans'

  resources :accounts

  resources :sessions, only: [:new, :create]
end
