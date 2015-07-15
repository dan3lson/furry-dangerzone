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
    let(:user) { FactoryGirl.create(:user) }

    scenario "scenario: click menu_path" do
      log_in_as(user)

      visit menu_path

      expect(page).to have_link("edit my profile")
      expect(page).to have_link("log out")
    end
  end
end
