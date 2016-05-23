Rails.application.routes.draw do
  root 'static_pages#guest_home'
  get "about_us" => "static_pages#about_us"
  get "search" => "searches#search"
  get "search_results" => "searches#search_results"
  get "search_myLeksi" => "searches#search_myLeksi"
  get "search_words_for_students" => "searches#student_words"
  get "menu" => "current_users#menu"
  get "progress" => "current_users#progress"
  get "myLeksi" => "my_leksi#index"
  get "myLeksi/:id" => "my_leksi#show"
  get "myTags" => "my_tags#index"
  get "myTags/:id" => "my_tags#show"
  get "jeopardy_tag" => "tag_games#jeopardy"
  get "fundamentals" => "games#fundamentals"
  get "jeopardy" => "games#jeopardy"
  get "freestyle" => "games#freestyle"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  get "blog" => "blog_posts#index"
  resources :blog_posts do
    resources :comments
  end
  resources :comments
  resources :users, except: [:index]
  resources :words, only: [:index, :show]
  resource :user_word, only: [:create, :update, :destroy]
  resource :user_points, only: [:update]
  resource :reset_fundamentals, only: [:update]
  resource :jeopardy_game, only: [:create, :update, :destroy]
  resource :freestyle_game, only: [:create, :update]
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
    root "schools#classes"
    get "classes" => "schools#classes"
    get "words" => "schools#words"
    get "student_words" => "words#student_words"
    get "students" => "schools#students"
    get "student" => "schools#student"
    get "messages" => "schools#messages"
    get "progress" => "schools#progress"
    get "menu" => "schools#menu"
    resources :words, only: [:new, :create, :edit, :update, :destroy]
    resource :add_words_for_student, only: [:update]
  end
  namespace :admin do
    root "admins#menu"
    get "stats" => "admins#stats"
    get "menu" => "admins#menu"
    resources :users, only: [:index]
  end
end
