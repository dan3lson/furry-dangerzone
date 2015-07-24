require 'rails_helper'

feature "user adds a tag", %{

  As a user,
  I want to add a tag to myTags.
} do

  # Acceptance Criteria
  #
  # [x] I can see a form to add a tag
  # [x] sources_path shows my newly added tag
  # [x] I see a message of success

  describe "\n user adds a tag -->" do
    let(:user) { FactoryGirl.create(:user) }

    scenario "scenario: with valid data" do
      log_in_as(user)

      visit myTags_path

      click_on "new source"

      fill_in "Name", with: "foo"

      click_on "Create source"

      expect(page).to have_content("Awesome - you added \'foo\'!")
      expect(UserSource.count).to eq(1)
      expect(Source.count).to eq(1)
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("errors")
      expect(page).not_to have_content("fix")
    end

    scenario "scenario: with invalid data" do
      log_in_as(user)

      visit myTags_path

      click_on "new source"

      fill_in "Name", with: ""

      click_on "Create source"

      expect(page).to have_content("Yikes!")
      expect(page).to have_content("error")
      expect(page).to have_content("fix")
      expect(UserSource.count).to eq(0)
      expect(Source.count).to eq(0)
      expect(page).not_to have_content("Awesome - you added \'foo\'!")
    end
  end
end