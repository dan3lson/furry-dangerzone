Rails.application.routes.draw do
  root 'static_pages#guest_home'
  get "about_us" => "static_pages#about_us"
  get "research" => "static_pages#research"
  get "our_approach" => "static_pages#our_approach"
  get "results" => "static_pages#results"
  get "feedback" => "feedbacks#new"
  get "search" => "searches#search"
  get "search_results" => "searches#results"
  get "settings" => "current_users#settings"
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
  post "static_pages/contact_us"
  delete "logout" => "sessions#destroy"
  resources :comments
  resources :users, except: [:index]
  resources :words, only: [:show]
  resources :words do
    resources :examples
  end
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
  namespace :school do
    root "current_user#classes"
    get "classes" => "current_user#classes"
    get "words" => "current_user#words"
    get "search" => "searches#search"
    get "search_results" => "searches#results"
    get "search_words_for_students" => "searches#student_words"
    get "student_words" => "words#student_words"
    get "frayer" => "words#frayer_model"
    get "students" => "current_user#students"
    get "student" => "current_user#student"
    get "messages" => "current_user#messages"
    get "progress" => "current_user#progress"
    get "settings" => "current_user#settings"
    get "seventh_grade_words" => "meaning_alts#seventh_grade"
    resources :words, only: [:new, :create]
    resource :add_words_for_student, only: [:update]
    resources :example_non_examples, only: [:index, :new]
    resources :words do
      resources :example_non_examples
    end
    resources :meaning_alts
    resources :words do
      resources :meaning_alts
    end
  end
  namespace :admin do
    root "admins#settings"
    get "stats" => "admins#stats"
    get "search" => "searches#search"
    get "search_results" => "searches#results"
    get "settings" => "admins#settings"
    resources :users
    resources :words
    resources :meaning_alts
    resources :example_non_examples
  end
end
