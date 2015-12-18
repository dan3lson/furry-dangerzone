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

      click_on "Activate Teacher Edition"

      within("#menu-tag-container") do
        expect(page).to have_link("View all")
        expect(page).to have_link("Create")
      end

      expect(page).to have_link("Activate Brainiac Edition")
      expect(page).to have_link("Create a word")
      expect(page).to have_link("Add words for students")
      expect(page).to have_link("Edit")
      expect(page).to have_link("Report a problem")
      expect(page).to have_link("I wish Leksi could...")
      expect(page).to have_link("Log out")
      expect(page).to have_content("Rate this app")
    end
  end
end
