FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "foobar#{n}" }
    password "password"
    password_confirmation "password"
    sequence(:email) { |n| "foo#{n}@bar.com" }
    num_logins 1
    login_history "Sat, 06 Aug 1988 00:00:00 +0000"
  end

  factory :word do
    sequence(:name) { |n| "chess #{n}" }
    phonetic_spelling "/tʃes/"
    definition "a game for two people, played on a board"
    part_of_speech "noun"
    example_sentence "Do you play chess?"
  end

  factory :user_word do
    user
    word
  end

  factory :tag do
    sequence(:name) { |n| "foo_tag#{n}" }
  end

  factory :user_tag do
    user
    tag
  end

  factory :word_tag do
    word
    tag
  end

  factory :user_word_tag do
    user
    word_tag
  end

  factory :version do
    description "Awesome new feature"
    sequence(:number) { |n| "1.0.#{n}" }
  end

  factory :review do
    description "this app is dope and pretty useful!"
    rating 5

    user
    version
  end

  factory :game do
    description "Begin to understand a word ..."
    name "Fundamentals"
  end

  factory :game_stat do
    num_played 3
    num_jeop_won 5
    num_jeop_lost 2
    time_spent 3

    user_word
    game
  end

  factory :feedback do
    description "Leksi could be a little faster."
    kind "wish"

    user
  end

  factory :blog_post do
    title "All About Leksi Part 1"
    content "Blog content for post numero uno."
    icon "gamepad"
    slug "all_about_leksi_part_1"
  end

  factory :comment do
    description "Wow, so clever. I really like it!"

    blog_post
  end
end
