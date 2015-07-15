require 'rails_helper'

feature "users add the same word", %{

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

  describe "\n two users add a word" do
    let!(:user_word) { FactoryGirl.create(:user_word) }
    let(:word) { user_word.word }
    let(:user_source) { FactoryGirl.create(:user_source) }
    let(:user2) { user_source.user }
    let!(:random_word_placeholder) { FactoryGirl.create(:word) }

    scenario "scenario: add word" do
      log_in_as(user2)

      visit search_path

      fill_in "Search", with: word.name

      click_on "define"

      click_on "add"

      select user_source.source.name, from: "Sources"

      click_on "add to myLeksi"

      expect(page).to have_content("Awesome - you added \'#{word.name}\'!")
      expect(page).not_to have_content("Yikes!")
      expect(page).to have_content(word.name)
      expect(page).to have_content(word.phonetic_spelling)
      expect(page).to have_content(word.part_of_speech)
      expect(page).to have_content(word.definition)
      expect(page).to have_content(word.example_sentence)
      expect(UserWord.count).to eq(2)
      expect(WordSource.count).to eq(1)
    end
  end
end
