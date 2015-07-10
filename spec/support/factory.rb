FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "foobar#{n}" }
    password "password"
    password_confirmation "password"
  end

  factory :word do
    sequence(:name) { |n| "foobar#{n}" }
    definition "lorem ipsum"
    part_of_speech "noun"
    pronunciation "foo-bar"
  end

  factory :user_word do
    user
    word
  end

  factory :source do
    sequence(:name) { |n| "foo_source#{n}" }

    user
  end
end
