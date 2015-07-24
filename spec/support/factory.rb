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
end
