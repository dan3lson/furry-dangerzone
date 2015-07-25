require 'rails_helper'

feature "add creates version", %{

  As an admin,
  I want to create a new
  version so folks can
  review it.
} do

  # Acceptance Criteria
  #
  # [x] I can visit /versions/new
  # [x] I see a review form
  # [x] I can see a success-message

  describe "\n admin creates version -->" do
    before :each do
      Version.create(number: "1.0.0", description: "Dope new feature!")
    end

    let!(:brainiac) { FactoryGirl.create(:user) }
    let!(:admin) { FactoryGirl.create(:user, role: "admin") }

    scenario "scenario: guest tries to create version" do
      visit new_version_path

      expect(page).to have_content("Yikes! Admins only ;)")
      expect(page).not_to have_content("New Review")
    end

    scenario "scenario: user(non-admin) tries to create version" do
      log_in_as(brainiac)

      visit new_version_path

      expect(page).to have_content("Yikes! Admins only ;)")
      expect(page).not_to have_content("New Review")
    end

    scenario "scenario: user(admin) with valid data" do
      log_in_as(admin)

      visit new_version_path

      fill_in "Number", with: "1.0.1"
      fill_in "Description", with: "Awesome new feature"

      click_on "Create version"

      expect(page).to have_content("Version \'1.0.1\' successfully created.")
      expect(Version.count).to eq(2)
      expect(page).to_not have_content("error")
      expect(page).to_not have_content("fix")
    end

    scenario "scenario: user(admin) with invalid data" do
      log_in_as(admin)

      visit new_version_path

      fill_in "Number", with: ""
      fill_in "Description", with: ""

      click_on "Create version"

      expect(page).not_to have_content("Version \'1.0.1\' successfully created.")
      expect(Version.count).to eq(1)
      expect(page).to have_content("error")
      expect(page).to have_content("fix")
    end
  end
end
