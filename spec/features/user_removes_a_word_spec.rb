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
  # [x] That word is no longer on my tags page
  # [x] I see a message of removal-success

  describe "\n user removes a word -->" do
    let(:user_word_1) { FactoryGirl.create(:user_word) }
    let(:user) { user_word_1.user }
    let!(:word) { user_word_1.word }

    scenario "scenario: remove word that is untagged" do
      log_in_as(user)

      visit notebook_path

      click_on word.name.capitalize

      within ".header-buttons" do
        click_on "remove"
      end

      expect(page).to have_content("has been removed.")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("foo-bar")
      expect(page).not_to have_content("lorem ipsum")
      expect(page).not_to have_content("noun")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end

    scenario "scenario: remove word that is tagged" do
      user_tag = FactoryGirl.create(:user_tag, user: user)
      tag = user_tag.tag
      user_word_tag = UserWordTag.create(
        user: user, word_tag: word_tag
      )

      log_in_as(user)

      visit notebook_path

      click_on word.name.capitalize

      within ".header-buttons" do
        click_on "remove"
      end

      expect(page).to have_content("has been removed.")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("foo-bar")
      expect(page).not_to have_content("lorem ipsum")
      expect(page).not_to have_content("noun")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end
  end
end
