require 'rails_helper'

feature "user removes a word", %{

  As a user,
  I want to remove a word from myLeksi.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "remove" button for the
  #     word I want
  # [x] myLeksi doesn't show my removed word
  # [x] I see a message of removal-success

  describe "\n user removes a word -->" do
    let(:user_word) { FactoryGirl.create(:user_word) }
    let(:user) { user_word.user }
    let!(:random_word_placeholder) { user_word.word }

    scenario "scenario: remove word" do
      log_in_as(user)

      click_on "remove"

      expect(page).to have_content("has been removed.")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("foo-bar")
      expect(page).not_to have_content("lorem ipsum")
      expect(page).not_to have_content("noun")
      expect(UserWord.count).to eq(0)
      expect(WordSource.count).to eq(0)
    end
  end
end
