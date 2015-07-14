Rails.application.routes.draw do
  root 'static_pages#home'
  get "menu" => "static_pages#menu"
  get "search" => "searches#new"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :users
  resources :words
  resource :user_word, only: [:create, :destroy]
  resources :sources
  resource :user_source, only: [:create, :destroy]
end
