Rails.application.routes.draw do
  root 'static_pages#guest_home'
  get "get_started" => "guests#get_started"
  get "get_started_game_zone" => "guests#game_zone"
  get "get_started_fundamentals" => "guests#fundamentals"
  put "get_started_stats" => "guests#update"
  get "about_us" => "static_pages#about_us"
  get "search" => "searches#search"
  get "search_results" => "searches#search_results"
  get "search_current_user_words" => "searches#search_current_user_words"
  get "menu" => "current_users#menu"
  get "myLeksi" => "current_users#myLeksi"
  get "myLeksi/:id" => "current_users#myLeksi_show"
  get "search_words_for_students" => "searches#student_words"
  get "progress" => "current_users#progress"
  get "myTags" => "my_tags#index"
  get "tag_rand_word" => "my_tags#random_word"
  get "weekly_goal" => "weekly_goals#weekly_goal"
  get "fundamentals" => "games#fundamentals"
  get "jeopardy" => "games#jeopardy"
  get "jeopardy_tag" => "tag_games#jeopardy"
  get "flashcards" => "flashcards#study"
  get "freestyle" => "games#freestyle"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  get "knowledge_scale" => "assessments#knowledge_scale"
  get "find_words_to_assess" => "assessments#search_results"
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
  resource :weekly_goal, only: [:update]
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
