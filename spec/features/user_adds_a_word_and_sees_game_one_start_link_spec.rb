require 'rails_helper'

feature "user adds a word and sees game one start link", %{

  As a user,
  I want to see a link to
  start game one for a word
  I just added to myLeksi.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "start" button for game
  #     one for a word just added

  describe "\n user adds a word -->" do
    scenario "scenario: valid process" do
      word = FactoryGirl.create(:word)
      user = FactoryGirl.create(:user)

      log_in_as(user)

      visit search_path

      fill_in "Search", with: "chess"

      click_on "look up"

      click_on "add"

      user_word = UserWord.first

      expect(page).to have_content("Chess")
      expect(page).to have_content("noun")
      expect(page).to have_content("a game for two people, played on a board")
      expect(page).to have_content("/tʃes/")
      expect(page).to have_css(".fund-show-game-circle")
      expect(Word.count).to eq(4)
      expect(UserWord.count).to eq(1)
      expect(user_word.games_completed).to eq(0)
    end
  end
end
