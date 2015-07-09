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

  describe "\n user adds a word" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:word) { FactoryGirl.create(:word) }

    scenario "scenario: remove word" do
      log_in_as(user)

      add_a_word

      click_on "remove"

      expect(page).to have_content("\'#{word.name}\' has been removed.")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content(word.definition)
      expect(page).not_to have_content(word.part_of_speech)
      expect(page).not_to have_content(word.pronunciation)
      expect(UserWord.count).to eq(0)
    end
  end
end
