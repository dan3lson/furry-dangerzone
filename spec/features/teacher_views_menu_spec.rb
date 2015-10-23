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

    let(:teacher) { FactoryGirl.create(:user) }

    scenario "scenario: click menu_path" do
      log_in_as(teacher)

      visit menu_path

      expect(page).to have_link("Create")
      expect(page).to have_link("Edit Profile")
      expect(page).to have_link("Log Out")
      expect(page).to have_content("Rate This App")
      expect(page).to have_button("submit")
    end
  end
end
