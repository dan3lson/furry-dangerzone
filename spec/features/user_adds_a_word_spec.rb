require 'rails_helper'

feature "user adds a word", %{

  As a user,
  I want to add a word to myLeksi.
} do

  # Acceptance Criteria
  #
  # [x] I can see an "add" button for the
  #     word I want
  # [x] I see a tag form to select a tag for that word
  # [x] myLeksi shows my newly added word
  # [x] I see a message of success

  describe "\n user adds a word -->" do
    scenario "scenario: valid process" do
      word = FactoryGirl.create(:word)
      user = User.create!(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password"
      )
      user_2 = User.create!(
        username: "fizzSober",
        password: "password",
        password_confirmation: "password"
      )
      user_word = UserWord.create!(word: word, user: user)
      game = Game.create!(
        name: "Fundamentals",
        description: "Learn the basics."
      )
      level = Level.create!(
        focus: "focus 1",
        direction: "direction 1"
      )
      level_2 = Level.create!(
        focus: "focus 2",
        direction: "direction 2"
      )
      level_3 = Level.create!(
        focus: "focus 3",
        direction: "direction 3"
      )
      level_4 = Level.create!(
        focus: "focus 4",
        direction: "direction 4"
      )
      level_5 = Level.create!(
        focus: "focus 5",
        direction: "direction 5"
      )
      level_6 = Level.create!(
        focus: "focus 6",
        direction: "direction 6"
      )
      level_7 = Level.create!(
        focus: "focus 7",
        direction: "direction 7"
      )
      level_8 = Level.create!(
        focus: "focus 8",
        direction: "direction 8"
      )
      game_level = GameLevel.create!(game: game, level: level)
      game_level_2 = GameLevel.create!(game: game, level: level_2)
      game_level_3 = GameLevel.create!(game: game, level: level_3)
      game_level_4 = GameLevel.create!(game: game, level: level_4)
      game_level_5 = GameLevel.create!(game: game, level: level_5)
      game_level_6 = GameLevel.create!(game: game, level: level_6)
      game_level_7 = GameLevel.create!(game: game, level: level_7)
      game_level_8 = GameLevel.create!(game: game, level: level_8)

      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level
      )
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_2
      )
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_3
      )
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_4
      )
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_5
      )
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_6
      )
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_7
      )
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_8
      )

      log_in_as(user_2)

      visit search_path

      fill_in "Search", with: "chess"

      click_on "define"

      click_on "add"

      expect(page).to have_content("Tap the play circle to begin learning ")
      expect(page).not_to have_content("Yikes!")
      expect(page).to have_content("chess")
      expect(page).to have_content("noun")
      expect(page).to have_content("a game for two people, played on a board")
      expect(page).to have_content("/tʃes/")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(2)
      expect(UserWordGameLevel.count).to eq(16)
    end
  end
end
