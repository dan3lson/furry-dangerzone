require 'rails_helper'

feature "admin activates admin portal", %{

  As an admin,
  I want to activate
  the admin portal.
} do

  # Acceptance Criteria
  #
  # [x] I can see link to activate admin protal
  # [x] I am denied if not an admin

  describe "\n admin access admin portal -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let(:admin) { FactoryGirl.create(:user, role: "admin") }
    let(:teacher) { FactoryGirl.create(:user, role: "teacher") }
    let(:user) { FactoryGirl.create(:user, role: "brainiac") }

    scenario "scenario: activates admin portal" do
      log_in_as(admin)

      visit menu_path

      click_on "Activate Admin Portal"

      expect(page).to have_link("Edit")
      expect(page).to have_link("Stats")
      expect(page).to have_link("Activate Brainiac Edition")
      expect(page).to have_link("Report a problem")
      expect(page).to have_link("I wish Leksi could...")
      expect(page).to have_link("Rate this app")
      expect(page).to have_link("Log out")
    end

    scenario "scenario: deny guests access to the admin portal" do
      visit admin_root_path

      expect(page).to have_content("Yikes!")
    end

    scenario "scenario: regular users cannot see admin portal link" do
      log_in_as(user)

      visit menu_path

      expect(page).not_to have_link("Activate Admin Portal")
    end

    scenario "scenario: regular users cannot access the admin portal" do
      log_in_as(user)

      visit admin_root_path

      expect(page).to have_content("Yikes! That\'s not something you can do.")
    end

    scenario "scenario: teachers cannot see admin portal link" do
      log_in_as(teacher)

      visit menu_path

      expect(page).not_to have_link("Activate Admin Portal")
    end

    scenario "scenario: teachers cannot access the admin portal" do
      log_in_as(teacher)

      visit admin_root_path

      expect(page).to have_content("Yikes! That\'s not something you can do.")
    end
  end
end
