require 'rails_helper'

feature "two users add the same tag", %{

  As a user,
  I want to add a tag
  that another use already added.
} do

  # Acceptance Criteria
  #
  # [x] I can see a form to add a tag
  # [x] mytags_path shows my newly added tag
  # [x] I see a message of success

  describe "\n two users add the same tag -->" do
    let!(:user_source) { FactoryGirl.create(:user_source) }
    let!(:source) { user_source.source }
    let(:user2) { FactoryGirl.create(:user) }

    scenario "scenario: add same source" do
      log_in_as(user2)

      visit myTags_path

      click_on "new source"

      fill_in "Name", with: source.name

      click_on "Create source"

      expect(page).to have_content("Awesome - you added \'#{source.name}\'!")
      expect(page).not_to have_content("Yikes!")
      expect(page).to have_content(source.name)
      expect(Source.count).to eq(1)
      expect(UserSource.count).to eq(2)
      expect(Word.count).to eq(0)
      expect(UserWord.count).to eq(0)
      expect(WordSource.count).to eq(0)
      expect(UserWordSource.count).to eq(0)
    end
  end
end
