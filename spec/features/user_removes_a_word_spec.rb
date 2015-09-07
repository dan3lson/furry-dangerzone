require 'rails_helper'

feature "user removes a word", %{

  As a user,
  I want to remove a word from myLeksi.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "remove" button for the
  #     word I want
  # [x] myLeksi doesn't show my removed word
  # [x] That word is no longer on my tags page
  # [x] I see a message of removal-success

  describe "\n user removes a word -->" do
    let(:user_word_1) { FactoryGirl.create(:user_word) }
    let(:user) { user_word_1.user }
    let!(:word) { user_word_1.word }

    scenario "scenario: remove word that is untagged" do
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

      within ".header-buttons" do
        click_on "remove"
      end

      expect(page).to have_content("has been removed.")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("foo-bar")
      expect(page).not_to have_content("lorem ipsum")
      expect(page).not_to have_content("noun")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(0)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
      expect(UserWordGameLevel.count).to eq(0)
    end

    scenario "scenario: remove word that is tagged" do
      user_tag = FactoryGirl.create(:user_tag, user: user)
      tag = user_tag.tag
      word_tag = WordTag.create(word: word, tag: tag)
      user_word_tag = UserWordTag.create(
        user: user, word_tag: word_tag
      )

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

      within ".header-buttons" do
        click_on "remove"
      end

      expect(page).to have_content("has been removed.")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("foo-bar")
      expect(page).not_to have_content("lorem ipsum")
      expect(page).not_to have_content("noun")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(0)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
      expect(UserWordGameLevel.count).to eq(0)
    end
  end
end
