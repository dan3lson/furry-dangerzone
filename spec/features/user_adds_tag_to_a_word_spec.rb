require 'rails_helper'

feature "user adds tag to a word", %{

  As a user,
  I already created a tag
  and want to add a tag to a word
  in myLeksi.
} do

  # Acceptance Criteria
  #
  # [x] I see a Tags section for one of my words
  # [x] I can select and add a tag for that word
  # [x] I see a message of success

  describe "\n user adds a tag to a word -->" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:word) { FactoryGirl.create(:word) }
    let!(:tag) { FactoryGirl.create(:tag) }
    let!(:user_word_1) { UserWord.create(user: user, word: word) }
    let!(:user_tag) { UserTag.create(user: user, tag: tag) }

    scenario "scenario: valid process" do
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

      visit myLeksi_path

      click_on word.name.capitalize

      select user_tag.tag.name, from: "Tags"

      click_on "add"

      expect(page).to have_content("Awesome - you tagged")
      expect(page).to have_content("to 'chess'!")
      expect(page).not_to have_content("Yikes!")
      expect(WordTag.count).to eq(1)
      expect(UserWordTag.count).to eq(1)
    end

    scenario "scenario: invalid process" do
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

      visit myLeksi_path

      click_on word.name.capitalize

      click_on "add"

      expect(page).not_to have_content("Awesome - you tagged")
      expect(page).not_to have_content("to 'chess'!")
      expect(page).to have_content(
        "Please select a tag before clicking \'add\'."
      )
      expect(WordTag.count).to eq(0)
    end
  end
end
