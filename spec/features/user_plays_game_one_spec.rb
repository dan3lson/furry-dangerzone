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
    let(:user_word_1) { FactoryGirl.create(:user_word) }
    let(:word) { user_word_1.word }
    let(:user) { user_word_1.user }

    scenario "scenario: plays game one without stopping" do
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
      fill_in "spell_the_word", with: "chess"
      click_on "continue"

      # Level 2
      click_on "c"
      click_on "h"
      click_on "e"
      click_on "s"
      click_on "s"
      click_on "continue"

      # Level 3
      click_on "pronunciation_button"
      click_on "continue"

      # Level 4
      click_on "meaning_row_button"
      click_on "continue"

      # Level 5
      click_on "synonym_row_button"
      click_on "continue"

      # Level 6
      click_on "antonym_row_button"
      click_on "continue"

      # Level 7
      click_on "synonym_antonym_checkpoint_button"
      click_on "continue"

      # Level 8
      click_on "real_world_example_row_button"
      click_on "continue"

      expect(page).to have_content("Congratulations!")
      expect(page).to have_content("You\'ve completed Game 1 for")
      expect(page).to have_content(word.name)
      expect(page).to have_content("and earned")
      expect(page).to have_content("experience points!")
      expect(page).to have_link("start next game")
      expect(user_word.game.where(name: "game one").status).to eq("complete")
      expect(user_word.activities.pluck(:completed).include?(false)).to eq(false)
    end
  end
end
