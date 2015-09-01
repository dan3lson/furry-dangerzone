require 'rails_helper'

feature "user searches for a word", %{

  As a user,
  I want to search for a word.
} do

  # Acceptance Criteria
  #
  # [x] I can visit search_path
  # [x] I see a form to submit my query
  # [x] I can see results
  # [] I can see a remove button for a
  #     word I already added

  skip "\n user searches for a word -->" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:word) { FactoryGirl.create(:word) }

    scenario "scenario: query is blank" do
      log_in_as(user)

      visit search_path

      fill_in "search", with: word.name

      click_on "define"

      expect(page).to have_content(word.name)
      expect(page).to have_content(word.phonetic_spelling)
      expect(page).to have_content(word.definition)
      expect(page).to have_content(word.part_of_speech)
      expect(page).to have_content(word.example_sentence)
    end

    scenario "scenario: query should be found" do
      log_in_as(user)

      visit search_path

      fill_in "search", with: "hacker"

      click_on "define"

      expect(page).to have_content("hacker")
      expect(page).to have_content("/ˈhækər/")
      expect(page).to have_content("noun")
      expect(page).to have_content("someone who uses a computer to connect to")
    end

    scenario "scenario: query should not be found" do
      log_in_as(user)

      visit search_path

      fill_in "search", with: "foobar"

      click_on "define"

      expect(page).to have_content("Yikes! We couldn\'t find 'foobar'.")
      expect(page).to have_content("Please search again!")
    end

    scenario "scenario: query should be found and is already added" do
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

      visit search_path

      fill_in "search", with: "chess"

      click_on "define"

      expect(page).to have_link("remove")
      expect(page).not_to have_content("add")
      expect(UserWordGameLevel.count).to eq(8)
    end
  end
end
