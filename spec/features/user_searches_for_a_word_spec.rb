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

  describe "\n user searches for a word" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:word) { FactoryGirl.create(:word) }

    scenario "scenario: query is blank" do
      log_in_as(user)

      visit search_path

      fill_in "search", with: ""

      click_on "define"

      expect(page).to have_content("foobar")
      expect(page).to have_content("lorem ipsum")
      expect(page).to have_content("noun")
      expect(page).to have_content("foo-bar")
    end

    scenario "scenario: query should be found" do
      log_in_as(user)

      visit search_path

      fill_in "search", with: "foobar"

      click_on "define"

      expect(page).to have_content("foobar")
      expect(page).to have_content("lorem ipsum")
      expect(page).to have_content("noun")
      expect(page).to have_content("foo-bar")
    end

    scenario "scenario: query should not be found" do
      log_in_as(user)

      visit search_path

      fill_in "search", with: "mangu"

      click_on "define"

      expect(page).to have_content("Sorry, we didn't find")
      expect(page).to have_content("Try again!")
    end
  end
end
