Rails.application.routes.draw do
  root 'static_pages#guest_home'
  get "about_us" => "static_pages#about_us"
  get "research" => "static_pages#research"
  get "our_approach" => "static_pages#our_approach"
  get "results" => "static_pages#results"
  get "search" => "searches#search"
  get "search_results" => "searches#search_results"
  get "search_words_for_students" => "searches#student_words"
  get "search_multi_words" => "searches#multiple_words"
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
  post "static_pages/contact_us"
  delete "logout" => "sessions#destroy"
  get "blog" => "blog_posts#index"
  get "all-about-leksi-part-1" => "blog_posts#all_about_leksi_part_1"
  get "all-about-leksi-part-2" => "blog_posts#all_about_leksi_part_2"
  get "seventh_grade_words" => "meaning_alts#seventh_grade"
  resources :blog_posts do
    resources :comments
  end
  resources :comments
  resources :users, except: [:index]
  resources :words, only: [:index, :show]
  resources :words do
    resources :examples
  end
  resources :words do
    resources :meaning_alts
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
  resource :landing_pages, only: [:create]
  resources :versions do
    resources :reviews
  end
  resources :reviews
  resources :feedbacks
  namespace :school do
    root "schools#classes"
    get "classes" => "schools#classes"
    get "words" => "schools#words"
    get "frayer" => "words#frayer_model"
    get "student_words" => "words#student_words"
    get "students" => "schools#students"
    get "student" => "schools#student"
    get "messages" => "schools#messages"
    get "progress" => "schools#progress"
    get "menu" => "schools#menu"
    resources :words, only: [:new, :create]
    resource :add_words_for_student, only: [:update]
    resources :example_non_examples, only: [:index, :new]
    resources :words do
      resources :example_non_examples
    end
  end
  namespace :admin do
    root "admins#menu"
    get "stats" => "admins#stats"
    get "menu" => "admins#menu"
    resources :users, only: [:index]
  end
end
