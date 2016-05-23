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
    let!(:user_tag) { FactoryGirl.create(:user_tag) }
    let!(:tag) { user_tag.tag }
    let(:user2) { FactoryGirl.create(:user) }

    scenario "scenario: add same tag" do
      log_in_as(user2)

      visit myTags_path

      find("#my-tags-new-btn").click

      fill_in "Name", with: tag.name

      click_on "Create tag"

      expect(page).to have_content("Success!")
      expect(page).not_to have_content("Yikes!")
      expect(Tag.count).to eq(1)
      expect(UserTag.count).to eq(2)
      expect(Word.count).to eq(0)
      expect(UserWord.count).to eq(0)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end
  end
end
