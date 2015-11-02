require 'rails_helper'

feature "user creates a tag", %{

  As a user,
  I want to create a tag to myTags.
} do

  # Acceptance Criteria
  #
  # [x] I can see a form to create a tag
  # [x] tags_path shows my newly created tag
  # [x] I see a message of success

  describe "\n user creates a tag -->" do
    let(:user) { FactoryGirl.create(:user) }

    scenario "scenario: with valid data" do
      log_in_as(user)

      visit myTags_path

      click_on "new tag"

      fill_in "Name", with: "foo"

      click_on "Create tag"

      expect(page).to have_content("Success!")
      expect(UserTag.count).to eq(1)
      expect(Tag.count).to eq(1)
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("errors")
      expect(page).not_to have_content("fix")
    end

    scenario "scenario: with invalid data" do
      log_in_as(user)

      visit myTags_path

      click_on "new tag"

      fill_in "Name", with: ""

      click_on "Create tag"

      expect(page).to have_content("Yikes!")
      expect(page).to have_content("error")
      expect(page).to have_content("fix")
      expect(UserTag.count).to eq(0)
      expect(Tag.count).to eq(0)
      expect(page).not_to have_content("Success")
    end
  end
end
