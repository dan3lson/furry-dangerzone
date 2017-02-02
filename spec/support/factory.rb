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

  factory :sent_stem do
    text "Feeling contrite about her actions, she ???."

    word
    user
  end
end
