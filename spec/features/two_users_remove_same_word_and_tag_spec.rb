require 'rails_helper'

feature "two users remove same word and tag", %{

  As user_1, I want to remove word_A and tag_A
  As user_2, I want to also remove
  word_A and tag_A
} do

  # Acceptance Criteria
  #
  # [x] As user_1 and user_2, I can see a
  #     "remove" button for the tag I want
  # [x] myTags doesn't show tag_A
  # [x] That /words/:id page doesn't show that tag
  # [x] I see a message of success

  describe "\n two users remove the same tag -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let!(:word) { FactoryGirl.create(:word) }
    let!(:tag) { FactoryGirl.create(:tag) }
    let!(:user_1) { FactoryGirl.create(:user) }
    let!(:user_2) { FactoryGirl.create(:user) }
    let!(:user_word_1) { UserWord.create(user: user_1, word: word) }
    let!(:user_word_2) { UserWord.create(user: user_2, word: word) }
    let!(:user_tag_1) { UserTag.create(user: user_1, tag: tag) }
    let!(:user_tag_2) { UserTag.create(user: user_2, tag: tag) }

    s = "scenario: "
    scenario s << "user_1 and user_2 remove same word (1st) and tag (2nd)" do
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

      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_2
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_3
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_4
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_5
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_6
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_7
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_8
      )

      log_in_as(user_1)

      click_on word.name

      click_on "remove"

      visit myTags_path

      click_on tag.name

      click_on "edit"

      click_on "remove"

      visit menu_path

      click_on "Log Out"

      log_in_as(user_2)

      click_on word.name

      click_on "remove"

      visit myTags_path

      click_on tag.name

      click_on "edit"

      click_on "remove"

      expect(Word.count).to eq(1)
      expect(Tag.count).to eq(0)
      expect(UserWord.count).to eq(0)
      expect(UserTag.count).to eq(0)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
      expect(UserWordGameLevel.count).to eq(0)
    end

    s = "scenario: "
    scenario s << "user_1 and user_2 remove same tag (1st) and word (2nd)" do
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

      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_2
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_3
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_4
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_5
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_6
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_7
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_8
      )

      log_in_as(user_1)

      visit myTags_path

      click_on tag.name

      click_on "edit"

      click_on "remove"

      visit myLeksi_path

      click_on word.name

      click_on "remove"

      log_in_as(user_2)

      visit myTags_path

      click_on tag.name

      click_on "edit"

      click_on "remove"

      visit myLeksi_path

      click_on word.name

      click_on "remove"

      expect(Word.count).to eq(1)
      expect(Tag.count).to eq(0)
      expect(UserWord.count).to eq(0)
      expect(UserTag.count).to eq(0)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
      expect(UserWordGameLevel.count).to eq(0)
    end
  end
end
