FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "foobar#{n}" }
    password "password"
    password_confirmation "password"
    email ""
  end

  factory :word do
    name "Chess"
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

  factory :level do
    direction "Type the word below:"
    focus "Spelling"
  end

  factory :game_level do
    game
    level
  end

  factory :user_word_game_level do
    status "not started"

    game_level
    user_word
  end

  factory :game_stat do
    num_played 3

    user_word
    game
  end
end
