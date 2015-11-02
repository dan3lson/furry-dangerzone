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
  get "jeopardy_tag" => "tag_games#jeopardy"
  get "freestyle" => "games#freestyle"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  get "classrooms" => "teachers#classrooms"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :users
  resources :words, only: [:index, :show]
  resource :user_word, only: [:create, :destroy]
  resource :user_points, only: [:update]
  resource :user_word_game_level, only: [:update]
  resource :reset_fundamentals, only: [:update]
  resource :jeopardy_game, only: [:create, :update, :destroy]
  resource :freestyle_game, only: [:create, :update]
  resource :create_freestyle, only: [:create]
  resource :game_stat, only: [:update]
  resource :jeopardy_result, only: [:update]
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
  resources :feedbacks
  namespace :school do
    root "schools#classrooms"
    get "home" => "schools#home"
    get "classes" => "schools#classes"
    get "words" => "schools#words"
    get "students" => "schools#students"
    get "student" => "schools#student"
    get "messages" => "schools#messages"
    get "progress" => "schools#progress"
    get "menu" => "schools#menu"
    resources :words, only: [:new, :create, :edit, :update, :destroy]
  end
end
