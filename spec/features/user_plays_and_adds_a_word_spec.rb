require 'rails_helper'

feature "user plays (and adds) a word", %{

  As a user,
  I want to see immediately play
  to learn a word and have it
  added to myLeksi.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "play" button
  # [x] I can see first level for
  #     the Fundamentals

  describe "\n user plays (and adds) a word -->", js: true do
    scenario "scenario: valid process" do
      word = FactoryGirl.create(:word)
      user = FactoryGirl.create(:user)

      log_in_as(user)

      visit search_path

      fill_in "Search", with: "chess"

      click_on "look up"

      click_on "Play"
      sleep(1)

      user_word = UserWord.first

      expect(page).to have_content("Type the word below:")
      expect(Word.count).to eq(4)
      expect(UserWord.count).to eq(1)
      expect(user_word.games_completed).to eq(0)
    end
  end
end
