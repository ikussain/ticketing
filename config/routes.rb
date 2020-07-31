Rails.application.routes.draw do
  root to: 'projects#index'

  resources :projects do
    resources :comments
  end  
end
