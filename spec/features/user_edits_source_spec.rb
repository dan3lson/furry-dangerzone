require 'rails_helper'

feature "user edits a source", %{

  As a user,
  I want to update one
  of my sources.
} do

  # Acceptance Criteria
  #
  # [x] I can visit edit_source_path(:id)
  # [x] I can see a form
  # [x] I see a button to update my source
  # [x] I can see errors if info isn't valid

  describe "\n user updates source" do
    let(:user_source) { FactoryGirl.create(:user_source) }
    let(:user) { user_source.user }
    let(:source) { user_source.source }

    scenario "scenario: with valid data" do
      log_in_as(user)

      visit sources_path

      click_on source.name

      click_on "edit"

      fill_in "Name", with: "FoooFooo"

      click_on "Save changes"

      expect(page).to have_content("Changes successfully made.")
      expect(page).to_not have_content("Yikes!")
      expect(page).to_not have_content("errors")
      expect(page).to_not have_content("fix")
    end

    scenario "scenario with invalid data" do
      log_in_as(user)

      visit sources_path

      click_on source.name

      click_on "edit"

      fill_in "Name", with: ""

      click_on "Save changes"

      expect(page).to have_content("Changes not successfully made.")
      expect(page).to have_content("Yikes!")
      expect(page).to have_content("error")
      expect(page).to have_content("fix")
    end
  end
end
