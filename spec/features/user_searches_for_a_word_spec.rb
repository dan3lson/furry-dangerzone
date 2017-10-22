require 'rails_helper'

feature "user searches for a word", %{

  As a user,
  I want to search for a word.
} do

  # Acceptance Criteria
  #
  # [x] I can visit dictionary_path
  # [x] I see a form to submit my query
  # [x] I can see results
  # [x] I can see a remove button for a
  #     word I already added

  pending "\n user searches for a word -->", js: true do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:word) { FactoryGirl.create(:word) }

    scenario "scenario: query is blank" do
      log_in_as(user)

      visit dictionary_path

      fill_in "search", with: word.name

      click_on "look up"

      expect(page).to have_content(word.name)
      expect(page).to have_content(word.phonetic_spelling)
      expect(page).to have_content(word.definition)
      expect(page).to have_content(word.part_of_speech)
      expect(page).to have_content(word.example_sentence)
    end

    scenario "scenario: query should be found" do
      log_in_as(user)

      visit dictionary_path

      fill_in "search", with: "hacker"

      click_on "look up"
      sleep(1)

      expect(page).to have_content("hacker")
      expect(page).to have_content("/ˈhækər/")
      expect(page).to have_content("noun")
      expect(page).to have_content("someone who uses a computer to connect to")
    end

    scenario "scenario: query should not be found" do
      log_in_as(user)

      visit dictionary_path

      fill_in "search", with: "foobar"

      click_on "look up"

      expect(page).to have_content("Yikes, we couldn\'t find 'foobar'.")
      expect(page).to have_content("Please search again.")
    end

    scenario "scenario: query should be found and is already added" do
      user_word = UserWord.create(user: user, word: word)

      log_in_as(user)

      visit dictionary_path

      fill_in "search", with: "chess"

      click_on "look up"
      sleep(1)

      expect(page).to have_link("Remove")
      expect(user_word.games_completed).to eq(0)
      expect(page).not_to have_content("add")
    end
  end
end
