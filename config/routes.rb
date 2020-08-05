Rails.application.routes.draw do
  root to: 'projects#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'


  resources :projects

  resources :tickets do
    resources :comments, only: [:create, :edit, :update]
  end

  resources :tags

  resources :users, only: [:create]
end
