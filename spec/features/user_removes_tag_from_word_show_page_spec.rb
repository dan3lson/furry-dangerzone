require 'rails_helper'

feature "user removes tag from word show page", %{

  As a user,
  I want to remove a tag for
  one of my words from that
  word's show page.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "remove" button
  # [x] That tag is no longer on /words/:id
  #     but is a tag I still have in myTags
  # [x] I see a message of removal-success

  describe "\n user removes a tag -->" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:word) { FactoryGirl.create(:word) }
    let!(:tag) { FactoryGirl.create(:tag) }
    let!(:user_tag) { UserTag.create(user: user, tag: tag) }
    let!(:user_word_1) { UserWord.create(user: user, word: word) }
    let!(:word_tag) { WordTag.create(word: word, tag: tag) }
    let!(:user_word_tag) { UserWordTag.create(
      user: user, word_tag: word_tag) }

    scenario "scenario: remove one tag from word show page" do
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

      within(".tag-on-word-show-page") do
        click_on "remove"
      end

      expect(page).to have_content("You removed \'")
      expect(page).not_to have_content("Yikes!")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(1)
      expect(Tag.count).to eq(1)
      expect(UserTag.count).to eq(1)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end

    scenario "scenario: remove one of two tags from word show page" do
      tag_2 = FactoryGirl.create(:tag, name: "foo_bar_tag")
      user_tag_2 = UserTag.create(user: user, tag: tag_2)
      word_tag_2 = WordTag.create(word: word, tag: tag_2)
      user_word_tag = UserWordTag.create(
        user: user, word_tag: word_tag_2
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

      within all(".tag-on-word-show-page").last do
        click_on "remove"
      end

      expect(page).to have_content("You removed \'")
      expect(page).not_to have_content("Yikes!")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(1)
      expect(Tag.count).to eq(2)
      expect(UserTag.count).to eq(2)
      expect(WordTag.count).to eq(1)
      expect(UserWordTag.count).to eq(1)
    end
  end
end
