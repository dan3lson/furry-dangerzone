FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "foobar#{n}" }
    password "password"
    password_confirmation "password"
  end

  factory :word do
    name "chess"
    phonetic_spelling "/tʃes/"
    definition "a game for two people, played on a board"
    part_of_speech "noun"
    example_sentence "Do you play chess?"
  end

  factory :user_word do
    user
    word
  end

  factory :source do
    sequence(:name) { |n| "foo_source#{n}" }
  end

  factory :user_source do
    user
    source
  end

  factory :word_source do
    word
    source
  end

  factory :user_word_source do
    user
    word_source
  end
end
