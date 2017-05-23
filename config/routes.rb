Rails.application.routes.draw do
  root "static_pages#home"
  get "about_us" => "static_pages#about_us"
  get "research" => "static_pages#research"
  get "spelling-bee" => "static_pages#spelling_bee"
  get "our_approach" => "static_pages#our_approach"
  get "results" => "static_pages#results"
  get "feedback" => "current_users#feedback"
  get "search" => "searches#search"
  get "search_grades" => "searches#grades"
  get "search_results" => "searches#results"
  get "searches/random"
  get "home" => "current_users#home"
  get "settings" => "current_users#settings"
  get "stats" => "current_users#stats"
  get "freestyles" => "current_users#freestyles"
  get "myLeksi" => "my_leksi#index"
  get "my_leksi/words"
  get "myLeksi/:id" => "my_leksi#show"
  get "myTags" => "my_tags#index"
  get "myTags/:id" => "my_tags#show"
  get "gamezone" => "games#gamezone"
  get "fundamentals" => "games#fundamentals"
  get "jeopardy" => "games#jeopardy"
  get "freestyle" => "games#freestyle"
  get "games/new"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  post "static_pages/contact_us"
  post "games/email_freestyle"
  delete "logout" => "sessions#destroy"
  resources :users, except: [:index]
  resources :words, only: [:show]
  resources :words do
    resources :examples
  end
  get "thesaurus/:word_name" => "words#thesaurus"
  resources :words do
    resources :meaning_alts, only: [:index]
  end
  resources :words do
    resources :example_non_examples, only: [:index]
  end
  resources :words do
    resources :sent_stems, only: [:index]
  end
  resource :user_word, only: [:create, :update, :destroy]
  resource :user_points, only: [:update]
  resource :jeopardy_game, only: [:create, :update, :destroy]
  resource :freestyle do
    member do
      post "sent_stem"
      post "word_rel"
      post "leksi_tale"
      post "describe_me"
      post "in_my_life"
    end
  end
  resource :game_stat do
    member do
      post "funds_one"
      post "funds_two"
      post "funds_three"
      post "funds_four"
      post "funds_five"
      post "funds_six"
      post "jeopardy"
    end
  end
  resource :jeopardy_result, only: [:update]
  resources :tags, except: [:destroy]
  resource :user_tag, only: [:create, :edit, :destroy]
  resource :word_tag, only: [:create, :destroy]
  resource :user_word_tag, only: [:create, :edit, :destroy]
  resource :user_word_tag_word_show_page, only: [:destroy]
  resource :user_word_tag_tag_show_page, only: [:destroy]
  namespace :games do
    resources :word_relationships, only: [:index]
    resources :describe_mes, only: [:index]
  end
  namespace :school do
    root "current_user#home"
    get "home" => "current_user#home"
    get "settings" => "current_user#settings"
    get "example_non_examples/fourth" => "example_non_examples#fourth_grade"
    get "decisions_decisions/fourth" => "meaning_alts#fourth_grade"
    get "search" => "searches#search"
    get "search_results" => "searches#results"
    get "search_words_for_students" => "searches#student_words"
    get "student_words" => "words#student_words"
    get "progress" => "classrooms#progress"
    get "my_meaning_alts" => "current_user#my_meaning_alts"
    get "words" => "classrooms#words"
    resources :classrooms do
      resources :students
    end
    resources :words, only: [:new, :create]
    resource :add_words_for_student, only: [:update] do
      member do
        post "by_grade"
      end
    end
    resources :freestyles do
      resources :comments
    end
    resources :example_non_examples
    resources :word do
      resources :example_non_examples
    end
    resources :meaning_alts
    resources :word do
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
    resources :classrooms
    resources :meaning_alts
    resources :example_non_examples
    resources :tags
    resources :freestyles
  end
end
