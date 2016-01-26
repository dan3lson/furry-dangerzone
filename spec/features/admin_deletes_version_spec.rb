require 'rails_helper'

feature "admin deletes version", %{

  As an admin,
  I want to delete a version.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "delete version" button
  # [x] I see a message of removal-success

  describe "\n admin deletes version -->" do
    let!(:admin) { FactoryGirl.create(:user, role: "admin") }
    let!(:version) { FactoryGirl.create(:version) }

    scenario "scenario: without reviews" do
      log_in_as(admin)

      visit edit_version_path(version)

      click_on "delete version"

      expect(page).to have_content("Version deleted.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(Version.count).to eq(0)
    end

    scenario "scenario: with reviews" do
      log_in_as(admin)

      visit edit_version_path(version)

      click_on "delete version"

      expect(page).to have_content("Version deleted.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(Version.count).to eq(0)
      expect(Review.count).to eq(0)
    end
  end
end
