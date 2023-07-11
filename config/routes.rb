# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  get 'user', to: 'users#show'

  resources :events

  root to: 'events#index'
end
