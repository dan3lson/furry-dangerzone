require 'rails_helper'

feature "two users remove a word", %{

  As user_1, I want to remove an untagged
  and / or tagged word from myLeksi.
  As user_2, I have that same word and
  don't want myLeksi and myTags to be
  changed because of what user_1 did.
  As user_2, I also want to remove that
  same tagged word.
} do

  # Acceptance Criteria
  #
  # [x] As user_1, I can see a "remove" button
  #     for the word I want
  # [x] As user_2, I can also see a "remove" button
  #     for that same word user_1 has
  # [x] myLeksi doesn't show my removed word
  # [x] That word is no longer on myTags page
  # [x] I see a message of removal-success

  describe "\n two users remove a word -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let!(:user_word) { FactoryGirl.create(:user_word) }
    let!(:word) { user_word.word }
    let!(:user_1) { user_word.user }
    let!(:user_2) { FactoryGirl.create(:user) }
    let!(:user_word_2) { UserWord.create(word: word, user: user_2) }

    scenario "scenario: user_1 removes untagged word (not tagged for user_2)" do
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

      expect(page).to have_content("has been removed.")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("foo-bar")
      expect(page).not_to have_content("lorem ipsum")
      expect(page).not_to have_content("noun")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(1)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
      expect(UserWordGameLevel.count).to eq(8)
    end

    scenario "scenario: user_1 removes tagged word (not tagged for user_2)" do
      user_tag = FactoryGirl.create(:user_tag, user: user_1)
      tag = user_tag.tag
      word_tag = WordTag.create(word: word, tag: tag)
      user_word_tag = UserWordTag.create(
        user: user_1, word_tag: word_tag
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

      within ".header-buttons" do
        click_on "remove"
      end

      expect(page).to have_content("has been removed.")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("foo-bar")
      expect(page).not_to have_content("lorem ipsum")
      expect(page).not_to have_content("noun")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(1)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
      expect(UserWordGameLevel.count).to eq(8)
    end

    scenario "scenario: user_1 removes tagged word (also tagged for user_2)" do
      user_tag = FactoryGirl.create(:user_tag, user: user_1)
      tag = user_tag.tag
      user_tag_2 = UserTag.create(tag: tag, user: user_2)
      word_tag = WordTag.create(word: word, tag: tag)
      user_word_tag = UserWordTag.create(
        user: user_1, word_tag: word_tag
      )
      user_word_tag = UserWordTag.create(
        user: user_2, word_tag: word_tag
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

      within ".header-buttons" do
        click_on "remove"
      end

      expect(page).to have_content("has been removed.")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("foo-bar")
      expect(page).not_to have_content("lorem ipsum")
      expect(page).not_to have_content("noun")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(1)
      expect(WordTag.count).to eq(1)
      expect(UserWordTag.count).to eq(1)
      expect(UserWordGameLevel.count).to eq(8)
    end

    scenario "scenario: user_1 and user_2 remove the same tagged word" do
      user_tag = FactoryGirl.create(:user_tag, user: user_1)
      tag = user_tag.tag
      user_tag_2 = UserTag.create(tag: tag, user: user_2)
      word_tag = WordTag.create(word: word, tag: tag)
      user_word_tag = UserWordTag.create(
        user: user_1, word_tag: word_tag
      )
      user_word_tag = UserWordTag.create(
        user: user_2, word_tag: word_tag
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

      within ".header-buttons" do
        click_on "remove"
      end

      visit menu_path

      click_on "Log Out"

      log_in_as(user_2)

      click_on word.name

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
