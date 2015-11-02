require 'rails_helper'

feature "teacher views the menu", %{

  As a teacher,
  I want to see menu options.
} do

  # Acceptance Criteria
  #
  # [x] I can see a menu button
  # [x] I can see links

  describe "\n teacher views links -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let(:teacher) { FactoryGirl.create(:user, role: "teacher") }

    scenario "scenario: click menu_path" do
      log_in_as(teacher)

      visit menu_path

      click_on "Activate Teacher\'s Edition"

      within(".new-tag-container") do
        expect(page).to have_link("Create")
      end

      within(".new-word-container") do
        expect(page).to have_link("Create")
      end
      expect(page).to have_link("Edit Profile")
      expect(page).to have_link("Log Out")
      expect(page).to have_content("Rate Leksi")
      expect(page).to have_button("submit")
    end
  end
end
