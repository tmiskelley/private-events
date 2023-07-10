# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  devise_for :users
  get 'users/:id', to: 'users#show'

  resources :events

  root to: 'events#index'
end
