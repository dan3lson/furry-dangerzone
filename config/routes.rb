Rails.application.routes.draw do
  root "static_pages#home"
  get "about-us" => "static_pages#about_us"
  get "research" => "static_pages#research"
  get "our-approach" => "static_pages#our_approach"
  get "results" => "static_pages#results"
  get "terms-of-use" => "static_pages#terms_of_use"
  get "privacy-policy" => "static_pages#privacy_policy"

  controller :blog do
    get "blog" => :index
    get "blog/first-harlem-spelling-bee" => :june_19_2017_first_harlem_spelling_bee
    get "blog/six-words-that-dont-mean-what-you-think" => :june_19_2017_six_words_that_dont_mean_what_you_think
    get "blog/about-our-name" => :june_19_2017_about_our_name
  end

  controller :spelling_bee do
    get "spelling-bee" => :index
    get "spelling-bee/about" => :about
    get "spelling-bee/competition" => :competition
    get "spelling-bee/teachers" => :teachers
    get "spelling-bee/sponsors" => :sponsors
    get "spelling-bee/contact-us" => :contact_us
  end

  get "feedback" => "current_users#feedback"
  get "dictionary" => "searches#dictionary"
  get "searches/section"
  get "searches/random"
  get "search_results" => "searches#results"
  get "stats" => "current_users#stats"
  get "freestyles" => "current_users#freestyles"
  get "notebook" => "my_leksi#index"
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
      post "ex_non_ex"
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
    resources :spellmasters, only: [:index]
  end

  namespace :school do
    root "classrooms#index"
    get "example_non_examples/fourth" => "example_non_examples#fourth_grade"
    get "decisions_decisions/fourth" => "meaning_alts#fourth_grade"
    get "example_non_examples/second" => "example_non_examples#second_grade"
    get "example_non_examples/fifth" => "example_non_examples#fifth_grade"
    get "example_non_examples/sixth" => "example_non_examples#sixth_grade"
    get "search" => "searches#search"
    get "search_words_for_students" => "searches#student_words"
    get "stats" => "stats#index"

    resources :classrooms do
      get "add_words" => "classrooms#add_words"
      resources :students
    end

    resources :words, except: [:show, :destroy]
    resource :add_words_for_student, only: [:update]

    resources :example_non_examples

    resources :word do
      resources :example_non_examples
    end

    resources :meaning_alts

    resources :word do
      resources :meaning_alts
    end

    resources :freestyles do
      resources :comments
    end
  end

  namespace :admin do
    root "admins#home"
    get "home" => "admins#home"
    get "stats" => "admins#stats"
    resources :users
    resources :words
    resources :classrooms
    resources :meaning_alts
    resources :example_non_examples
    resources :tags
    resources :freestyles
  end
end
