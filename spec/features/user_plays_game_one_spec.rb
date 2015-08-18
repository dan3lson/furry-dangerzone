require 'rails_helper'

feature "user plays game one", %{

  As a user,
  I want to play the first game
  for one of my words.
} do

  # Acceptance Criteria
  #
  # [] Clicking on "start" takes me to
  #    the first level of Game 1
  # [] I can complete 8 levels or go back
  #    to /words/:id

  describe "\n user plays game one -->" do
    skip "scenario: plays game one without stopping", js: true do
      word = Word.create(
        name: "time",
        definition: "the quantity that you measure using a clock"
      )
      user = FactoryGirl.create(:user)
      user_word_1 = UserWord.create(user: user, word: word)

			create_levels_and_games

			game_level = GameLevel.all[-8]
			game_level_2 = GameLevel.all[-7]
			game_level_3 = GameLevel.all[-6]
			game_level_4 = GameLevel.all[-5]
			game_level_5 = GameLevel.all[-4]
			game_level_6 = GameLevel.all[-3]
			game_level_7 = GameLevel.all[-2]
			game_level_8 = GameLevel.all[-1]

			UserWordGameLevel.create!(
				user_word: user_word_1,
				game_level: game_level
			)
			UserWordGameLevel.create!(
				user_word: user_word_1,
				game_level: game_level_2
			)
			UserWordGameLevel.create!(
				user_word: user_word_1,
				game_level: game_level_3
			)
			UserWordGameLevel.create!(
				user_word: user_word_1,
				game_level: game_level_4
			)
			UserWordGameLevel.create!(
				user_word: user_word_1,
				game_level: game_level_5
			)
			UserWordGameLevel.create!(
				user_word: user_word_1,
				game_level: game_level_6
			)
			UserWordGameLevel.create!(
				user_word: user_word_1,
				game_level: game_level_7
			)
			UserWordGameLevel.create!(
				user_word: user_word_1,
				game_level: game_level_8
			)

      log_in_as(user)

      click_on "start"

      # Level 1
      fill_in "spell_the_word", with: "time"
      click_on "continue"

      # Level 2
      page.find(".letter_t").click
      page.find(".letter_i").click
      page.find(".letter_m").click
      page.find(".letter_e").click
      click_on "continue"

      # Level 3
      page.find("#pronunciation_image_button").click
      click_on "continue"

      # Level 4
      page.find(".meaning_row").click
      click_on "continue"

      # Level 5
      sleep(3)
      click_on "continue"

      # Level 6
      sleep(3)
      click_on "continue"

      # Level 7
      page.find("#syn_ant_checkpoint_continue_button").click

      # Level 8
      page.find(".rwe_row_0").click
      page.find(".rwe_row_1").click
      page.find(".rwe_row_2").click
      click_on "continue"
      sleep(3)

      expect(page).to have_content("Congratulations!")
      expect(page).to have_content("You\'ve completed the Fundamentals for")
      expect(page).to have_content(word.name)
      expect(page).to have_content("and earned")
      expect(page).to have_content("experience points!")
      expect(user_word_1.game_levels.pluck(:status).include?("not started")).to eq(false)
    end
  end
end
