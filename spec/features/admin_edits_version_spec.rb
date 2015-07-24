require 'rails_helper'

feature "admin edits version", %{

  As an admin user,
  I want to update a version.
} do

  # Acceptance Criteria
  #
  # [x] I can visit /versions/:id/edit
  # [x] I can see a form
  # [x] I see a button to update the version
  # [x] I can see errors if info isn't valid

  describe "\n admin updates version -->" do
    let(:admin) { FactoryGirl.create(:user, role: "admin") }
    let!(:version) { FactoryGirl.create(:version) }

    scenario "scenario: with valid data" do
      log_in_as(admin)

      visit edit_version_path(version)

      fill_in "Number", with: "3"

      click_on "Save changes"

      expect(page).to have_content("Changes successfully made.")
      expect(page).to_not have_content("error")
      expect(page).to_not have_content("fix")
    end

    scenario "scenario: with invalid data" do
      log_in_as(admin)

      visit edit_version_path(version)

      fill_in "Number", with: ""

      click_on "Save changes"

      expect(page).not_to have_content("Changes successfully made.")
      expect(page).to have_content("error")
      expect(page).to have_content("fix")
    end
  end
end
