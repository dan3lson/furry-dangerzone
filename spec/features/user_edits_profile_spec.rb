require 'rails_helper'

feature "user edits their profile", %{

  As a user,
  I want to update my profile.
} do

  # Acceptance Criteria
  #
  # [x] I can visit /users/:id/edit
  # [x] I can see a form
  # [x] I see a button to update my account
  # [x] I can see errors if info isn't valid

  describe "\n user updates account -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let(:user) { FactoryGirl.create(:user) }

    scenario "scenario: with valid data" do
      log_in_as(user)

      visit menu_path

      click_on "Edit Profile"

      fill_in "Username", with: "FoooFooo"
      fill_in "Password", with: "fooobar"
      fill_in "Password Confirmation", with: "fooobar"

      click_on "Save changes"

      expect(page).to have_content("You successfully updated your profile.")
      expect(page).to_not have_content("error")
    end

    scenario "scenario: with invalid data" do
      log_in_as(user)

      visit menu_path

      click_on "Edit Profile"

      fill_in "Username", with: ""
      fill_in "Password", with: ""
      fill_in "Password Confirmation", with: ""

      click_on "Save changes"

      expect(page).to_not have_content("You successfully updated your profile.")
      expect(page).to have_content("error")
      expect(page).to have_content("Profile")
    end
  end
end
