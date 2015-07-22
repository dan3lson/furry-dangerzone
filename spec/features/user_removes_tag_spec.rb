require 'rails_helper'

feature "user removes tag", %{

  As a user,
  I want to remove a tag from myTags.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "remove" button
  # [x] I see a message of success

  describe "\n user removes tag -->" do
    let!(:user_source) { FactoryGirl.create(:user_source) }
    let!(:source) { user_source.source }
    let!(:user) { user_source.user }
    let(:word) { FactoryGirl.create(:word) }

    scenario "scenario: remove tag without words" do
      log_in_as(user)

      visit myTags_path

      click_on source.name

      click_on "remove"

      expect(page).to have_content("\'#{source.name}\' has been removed.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(Source.count).to eq(0)
      expect(UserSource.count).to eq(0)
      expect(WordSource.count).to eq(0)
      expect(UserWordSource.count).to eq(0)
    end

    scenario "scenario: remove tag with words" do
      user_word = UserWord.create(user: user, word: word)
      word_source = WordSource.create(word: word, source: source)
      user_word_source = UserWordSource.create(
        user: user, word_source: word_source
      )

      log_in_as(user)

      visit myTags_path

      click_on source.name

      click_on "remove"

      expect(page).to have_content("You removed \'#{source.name}\'.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(1)
      expect(Source.count).to eq(0)
      expect(UserSource.count).to eq(0)
      expect(WordSource.count).to eq(0)
      expect(UserWordSource.count).to eq(0)
    end
  end
end
