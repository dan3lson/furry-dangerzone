require 'rails_helper'

feature "user deletes source", %{

  As a user,
  I want to delete a source.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "delete" button
  # [x] I see a message of deletion-success

  describe "\n user deletes source -->" do

    let(:user_source) { FactoryGirl.create(:user_source) }
    let(:source) { user_source.source }
    let(:user) { user_source.user }
    let(:word) { FactoryGirl.create(:word) }

    before :each do
      untagged_source = Source.first
      user.sources <<  untagged_source
    end

    scenario "scenario: delete source without words" do
      log_in_as(user)

      visit myTags_path

      click_on source.name

      click_on "remove"

      expect(page).to have_content("\'#{source.name}\' has been removed.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(Source.count).to eq(2)
      expect(UserSource.count).to eq(1)
      expect(WordSource.count).to eq(0)
    end

    scenario "scenario: delete source with words" do
      user.words << word
      word_source = WordSource.create(word: word, source: source)
      untagged_source = Source.first

      log_in_as(user)

      visit myTags_path

      click_on source.name

      click_on "remove"

      expect(page).to have_content("\'#{source.name}\' has been removed.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(Source.count).to eq(2)
      expect(UserSource.count).to eq(1)
      expect(WordSource.count).to eq(1)
      expect(untagged_source.words.count).to eq(1)
    end
  end
end
