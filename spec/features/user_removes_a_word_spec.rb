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
    let(:user_word) { FactoryGirl.create(:user_word) }
    let(:user) { user_word.user }
    let!(:word) { user_word.word }

    scenario "scenario: remove word that is untagged" do
      log_in_as(user)

      click_on word.name

      click_on "remove"

      expect(page).to have_content("has been removed.")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("foo-bar")
      expect(page).not_to have_content("lorem ipsum")
      expect(page).not_to have_content("noun")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(0)
      expect(WordSource.count).to eq(0)
      expect(UserWordSource.count).to eq(0)
    end

    scenario "scenario: remove word that is tagged" do
      user_source = FactoryGirl.create(:user_source, user: user)
      source = user_source.source
      word_source = WordSource.create(word: word, source: source)
      user_word_source = UserWordSource.create(
        user: user, word_source: word_source
      )

      log_in_as(user)

      click_on word.name

      click_on "remove"

      expect(page).to have_content("has been removed.")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("foo-bar")
      expect(page).not_to have_content("lorem ipsum")
      expect(page).not_to have_content("noun")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(0)
      expect(WordSource.count).to eq(0)
      expect(UserWordSource.count).to eq(0)
    end
  end
end
