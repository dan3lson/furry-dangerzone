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

  describe "\n user searches for a word -->" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:random_word_placeholder) { FactoryGirl.create(:word) }

    scenario "scenario: query is blank" do
      log_in_as(user)

      visit search_path

      fill_in "search", with: random_word_placeholder.name

      click_on "define"

      expect(page).to have_content(random_word_placeholder.name)
      expect(page).to have_content(random_word_placeholder.phonetic_spelling)
      expect(page).to have_content(random_word_placeholder.definition)
      expect(page).to have_content(random_word_placeholder.part_of_speech)
      expect(page).to have_content(random_word_placeholder.example_sentence)
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
  end
end
