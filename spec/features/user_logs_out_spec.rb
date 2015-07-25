require 'rails_helper'

feature "user logs out", %{

  As a user,
  I want to log out of Leksi.
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

      click_on "menu"

      click_on "log out"

      expect(page).to have_content("See you again, #{user.username}!")
      expect(page).to have_link("Get for free")
      expect(page).to have_link("log in")
    end
  end
end
