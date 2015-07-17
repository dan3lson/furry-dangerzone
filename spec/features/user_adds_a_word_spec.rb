require 'rails_helper'

feature "user adds a word", %{

  As a user,
  I want to add a word to myLeksi.
} do

  # Acceptance Criteria
  #
  # [x] I can see an "add" button for the
  #     word I want
  # [] I can select a source for that word
  # [x] myLeksi shows my newly added word
  # [x] I see a message of success

  describe "\n user adds a word -->" do
    let(:user_source) { FactoryGirl.create(:user_source) }
    let(:user) { user_source.user }
    let!(:random_word_placeholder) { FactoryGirl.create(:word) }

    scenario "scenario: valid process" do
      log_in_as(user)

      visit search_path

      fill_in "Search", with: "chess"

      click_on "define"

      click_on "add"

      select user_source.source.name, from: "Sources"

      click_on "add to myLeksi"

      expect(page).to have_content("Awesome - you added \'chess\'!")
      expect(page).not_to have_content("Yikes!")
      expect(page).to have_content("chess")
      expect(page).to have_content("noun")
      expect(page).to have_content("a game for two people, played on a board")
      expect(page).to have_content("/tʃes/")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(1)
      expect(WordSource.count).to eq(1)
    end

    pending "scenario: invalid process" do
      log_in_as(user)

      visit search_path

      fill_in "Search", with: "chess"

      click_on "define"

      click_on "add"

      click_on "add to myLeksi"

      expect(page).not_to have_content("Awesome - you added \'chess\'!")
      expect(page).to have_content("Yikes!")
      expect(page).not_to have_content("chess")
      expect(page).not_to have_content("noun")
      expect(page).not_to have_content("a game for two people, played on a board")
      expect(page).not_to have_content("/tʃes/")
      expect(Word.count).to eq(0)
      expect(UserWord.count).to eq(0)
      expect(WordSource.count).to eq(0)
    end
  end
end
