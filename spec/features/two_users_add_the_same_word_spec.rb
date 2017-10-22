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

  pending "\n two users add same word -->", js: true do
    let!(:user_word) { FactoryGirl.create(:user_word) }
    let!(:word) { user_word.word }
    let(:user_2) { FactoryGirl.create(:user) }

    scenario "scenario: add word" do
      log_in_as(user_2)

      visit dictionary_path

      fill_in "Search", with: word.name

      click_on "look up"
      sleep(1)

      click_on "Add"
      sleep(1)

      expect(page).not_to have_content("Yikes!")
      expect(page).to have_content("Success! You now have")
      expect(UserWord.count).to eq(2)
      expect(UserTag.count).to eq(0)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end
  end
end
