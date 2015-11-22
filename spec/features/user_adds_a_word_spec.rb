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

  describe "\n user adds a word -->" do
    scenario "scenario: valid process" do
      user = FactoryGirl.create(:user)
      word = FactoryGirl.create(:word)

      log_in_as(user)

      visit search_path

      fill_in "Search", with: "chess"

      click_on "look up"

      click_on "add"

      expect(page).not_to have_content("Yikes!")
      expect(page).to have_content("Chess")
      expect(page).to have_content("noun")
      expect(page).to have_content("a game for two people, played on a board")
      expect(page).to have_content("/tʃes/")
      expect(Word.count).to eq(4)
      expect(UserWord.count).to eq(1)
      expect(UserWord.first.games_completed).to eq(0)
    end
  end
end
