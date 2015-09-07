require 'rails_helper'

feature "user visits home page", %{

  As a (logged in) user,
  I want to go to the Leksi.education homepage.
} do

  # Acceptance Criteria
  #
  # [x] I can visit /
  # [x] I see myLeksi

  describe "\n visit home page -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let(:user_word_1) { FactoryGirl.create(:user_word) }
    let(:user) { user_word_1.user }
    let(:word) { user_word_1.word }

    scenario "scenario: myLeksi is displayed" do
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

      visit menu_path

      visit root_path

      expect(page).to have_content(word.name.capitalize)
      expect(page).to have_content(word.phonetic_spelling)
      expect(page).to have_content(word.part_of_speech)
      expect(page).to have_content(word.definition)
    end
  end
end
