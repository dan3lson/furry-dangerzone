require 'rails_helper'

feature "two users add the same word", %{

  As a user,
  I want to add a word to myLeksi
  that another user already added.
} do

  # Acceptance Criteria
  #
  # [x] I can see an "add" button for the
  #     word I want
  # [x] myLeksi shows my newly added word
  # [x] I see a message of success

  describe "\n two users add same word -->" do
    let!(:user_word) { FactoryGirl.create(:user_word) }
    let!(:word) { user_word.word }
    let(:user2) { FactoryGirl.create(:user) }

    scenario "scenario: add word" do
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

      log_in_as(user2)

      visit search_path

      fill_in "Search", with: word.name

      click_on "look up"

      click_on "add"

      expect(page).not_to have_content("Yikes!")
      expect(page).to have_content(word.name)
      expect(page).to have_content(word.phonetic_spelling)
      expect(page).to have_content(word.part_of_speech)
      expect(page).to have_content(word.definition)
      expect(page).to have_content(word.example_sentence)
      expect(Word.count).to eq(4)
      expect(UserWord.count).to eq(2)
      expect(UserTag.count).to eq(0)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
      expect(UserWordGameLevel.count).to eq(16)
    end
  end
end
