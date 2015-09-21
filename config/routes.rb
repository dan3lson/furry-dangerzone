Rails.application.routes.draw do
  root 'static_pages#guest_home'
  get "menu" => "current_users#menu"
  get "home" => "current_users#home"
  get "myLeksi" => "current_users#myLeksi"
  get "search" => "searches#new"
  get "progress" => "current_users#progress"
  get "myTags" => "current_users#tags"
  get "fundamentals" => "games#fundamentals"
  get "jeopardy" => "games#jeopardy"
  get "jeopardy_game_words" => "games#jeopardy_game_words"
  get "leaderboard" => "games#leaderboard"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :users
  resources :words
  resource :user_word, only: [:create, :destroy]
  resource :user_word_game_level, only: [:update]
  resource :user_points, only: [:update]
  resource :user_word_game_level_jeopardy, only: [:create]
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
