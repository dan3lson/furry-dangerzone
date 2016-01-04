require 'rails_helper'

feature "user logs out", %{

  As a user,
  I want to Log out of Leksi.
} do

  # Acceptance Criteria
  #
  # [x] I can visit /login
  # [x] I can sign in
  # [x] I can sign out
  # [x] I'm taken to the root_path

  describe "\n user logs out -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let(:user) { FactoryGirl.create(:user) }

    scenario "scenario: logs out" do
      log_in_as(user)

      click_on "Menu"

      click_on "Log out"

      expect(page).to have_content("Get started")
      expect(page).to have_link("Log in")
      expect(page).to have_content("Boost your vocabulary with Leksi.")
    end
  end
end
