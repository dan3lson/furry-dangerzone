require 'rails_helper'

feature "user edits a source", %{

  As a user,
  I want to update one
  of my sources.
} do

  # Acceptance Criteria
  #
  # [] I can visit edit_source_path(:id)
  # [] I can see a form
  # [] I see a button to update my source
  # [] I can see errors if info isn't valid

  describe "\n user updates source" do
    let(:user) { FactoryGirl.create(:user) }
    let(:source) { FactoryGirl.create(:source) }

    pending "scenario: with valid data" do
      log_in_as(user)

      visit sources_path

      click_on source.name

      click_on "Edit"

      fill_in "Name", with: "FoooFooo"

      click_on "Save changes"

      expect(page).to have_content("Changes successfully made.")
      expect(page).to_not have_content("Yikes!")
      expect(page).to_not have_content("errors")
      expect(page).to_not have_content("fix")
    end

    pending "scenario with invalid data" do
      log_in_as(user)

      visit sources_path

      click_on source.name

      click_on "Edit"

      fill_in "Name", with: ""

      click_on "Save changes"

      expect(page).to have_content("Changes not successfully made.")
      expect(page).to have_content("Yikes!")
      expect(page).to have_content("errors")
      expect(page).to have_content("fix")
    end
  end
end
