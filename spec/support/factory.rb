FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    type "Student"
    password "password"
    password_confirmation "password"
    sequence(:email) { |n| "user#{n}@foo.com" }
    num_logins 1
    login_history "Sat, 06 Aug 1988 00:00:00 +0000"
  end

  factory :teacher do
    sequence(:username) { |n| "teacher#{n}" }
    type "Teacher"
    password "password"
    password_confirmation "password"
    sequence(:email) { |n| "teacher#{n}@foo.com" }
    num_logins 1
    login_history "Sat, 06 Aug 1988 00:00:00 +0000"
  end

  factory :student do
    sequence(:username) { |n| "student#{n}" }
    type "Student"
    password "password"
    password_confirmation "password"
    sequence(:email) { |n| "student#{n}@foo.com" }
    num_logins 1
    login_history "Sat, 06 Aug 1988 00:00:00 +0000"

    teacher
    classroom
  end

  factory :word do
    sequence(:name) { |n| "chess #{n}" }
    phonetic_spelling "/tʃes/"
    definition "a game for two people, played on a board"
    part_of_speech "noun"
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

  factory :game do
    description "Type the word as fast as you can!"
    name "Speed Speller"
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

  factory :classroom do
    sequence(:name) { |n| "Classroom#{n}" }
    grade 8

    teacher
  end

  factory :freestyle do
    input "Technology is the future."
    status "not reviewed"

    user_word
  end
end
