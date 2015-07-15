FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "foobar#{n}" }
    password "password"
    password_confirmation "password"
  end

  factory :word do
    name "chess"
    definition "a game for two people, played on a board"
    example_sentence "Do you play chess?"
    part_of_speech "noun"
    phonetic_spelling "/tʃes/"
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
end
