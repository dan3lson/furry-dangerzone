require 'rails_helper'

feature "user views the menu", %{

  As a user,
  I want to see menu options.
} do

  # Acceptance Criteria
  #
  # [x] I can see a menu button
  # [x] I can see links

  describe "\n user views links -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let(:user) { FactoryGirl.create(:user) }

    scenario "scenario: click menu_path" do
      log_in_as(user)

      visit menu_path

      within("#menu-tag-container") do
        expect(page).to have_link("View all")
        expect(page).to have_link("Create")
      end

      expect(page).to have_link("Report a problem")
      expect(page).to have_link("I wish Leksi could...")
      expect(page).to have_link("Log out")
      expect(page).to have_content("Rate this app")
    end
  end
end
