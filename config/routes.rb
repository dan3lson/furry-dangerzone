Rails.application.routes.draw do
  root 'static_pages#home'
  get "menu" => "static_pages#menu"
  get "search" => "searches#new"
  get "myLeksi" => "current_users#words"
  get "myTags" => "current_users#tags"
  get "fundamentals" => "games#fundamentals"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :users
  resources :words
  resource :user_word, only: [:create, :destroy]
  resource :user_word_game_level, only: [:update]
  resources :tags, except: [:destroy]
  resource :user_tag, only: [:create, :edit, :destroy]
  resource :word_tag, only: [:create, :destroy]
  resource :user_word_tag, only: [:create, :edit, :destroy]
  resource :user_word_tag_word_show_page, only: [:destroy]
  resource :user_word_tag_tag_show_page, only: [:destroy]
  resources :versions do
    resources :reviews
  end
  resources :reviews
end
