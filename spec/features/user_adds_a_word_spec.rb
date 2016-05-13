require 'rails_helper'

feature "user adds a word", %{

  As a user,
  I want to add a word to myLeksi.
} do

  # Acceptance Criteria
  #
  # [x] I see an "add" button for the
  #     word I want
  # [x] I can then see a tag form to select a tag for that word
  # [x] myLeksi shows my newly added word
  # [x] I see a message of success

  pending "\n user adds a word -->" do
    scenario "scenario: valid process", js: true do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:word)

      log_in_as(user)

      visit search_path

      fill_in "Search", with: "chess"
      click_on "look up"
      sleep(1)

      click_on "Add"
      sleep(1)

      expect(page).not_to have_content("Yikes!")
      expect(page).to have_content("Success! You now have")
      expect(UserWord.count).to eq(1)
      expect(UserWord.first.games_completed).to eq(0)
    end
  end
end
