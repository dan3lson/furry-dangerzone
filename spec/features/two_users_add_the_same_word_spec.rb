require 'rails_helper'

feature "two users add the same word", %{

  As a user,
  I want to add a word to myLeksi
  that another use already added.
} do

  # Acceptance Criteria
  #
  # [x] I can see an "add" button for the
  #     word I want
  # [x] myLeksi shows my newly added word
  # [x] I see a message of success

  describe "\n two users add a word -->" do
    let!(:user_word) { FactoryGirl.create(:user_word) }
    let!(:word) { user_word.word }
    let(:user2) { FactoryGirl.create(:user) }

    scenario "scenario: add word" do
      log_in_as(user2)

      visit search_path

      fill_in "Search", with: word.name

      click_on "define"

      click_on "add"

      expect(page).to have_content("Awesome - you added \'#{word.name}\'!")
      expect(page).not_to have_content("Yikes!")
      expect(page).to have_content(word.name)
      expect(page).to have_content(word.phonetic_spelling)
      expect(page).to have_content(word.part_of_speech)
      expect(page).to have_content(word.definition)
      expect(page).to have_content(word.example_sentence)
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(2)
      expect(UserSource.count).to eq(0)
      expect(WordSource.count).to eq(0)
      expect(UserWordSource.count).to eq(0)
    end
  end
end
