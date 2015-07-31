require 'rails_helper'

feature "user removes tag", %{

  As a user,
  I want to remove a tag from myTags.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "remove" button
  # [x] I see a message of success

  describe "\n user removes tag -->" do
    let!(:user_tag) { FactoryGirl.create(:user_tag) }
    let!(:tag) { user_tag.tag }
    let!(:user) { user_tag.user }
    let(:word) { FactoryGirl.create(:word) }

    scenario "scenario: remove tag without words" do
      log_in_as(user)

      visit myTags_path

      click_on tag.name

      click_on "edit"

      click_on "remove"

      expect(page).to have_content("\'#{tag.name}\' has been removed.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(Tag.count).to eq(0)
      expect(UserTag.count).to eq(0)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end

    scenario "scenario: remove tag with words" do
      user_word_1 = UserWord.create(user: user, word: word)
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

      visit myTags_path

      click_on tag.name

      click_on "edit"

      within ".header-buttons" do
        click_on "remove"
      end

      expect(page).to have_content("You removed \'#{tag.name}\'.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(1)
      expect(Tag.count).to eq(0)
      expect(UserTag.count).to eq(0)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end
  end
end
