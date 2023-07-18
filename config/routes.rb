# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  root to: 'events#index'

  get 'user', to: 'users#show'
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :events

  resources :event_attendees, only: [:new, :create]
end
