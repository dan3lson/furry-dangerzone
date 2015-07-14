require 'rails_helper'

feature "user creates a source", %{

  As a user,
  I want to create a source.
} do

  # Acceptance Criteria
  #
  # [x] I can see a form to add a source
  # [x] sources_path shows my newly added source
  # [x] I see a message of success

  describe "\n user creates a source" do
    let(:user) { FactoryGirl.create(:user) }

    scenario "scenario: with valid data" do
      log_in_as(user)

      create_source

      expect(page).to have_content("You successfully created a new source!")
      expect(UserSource.count).to eq(1)
      expect(Source.count).to eq(1)
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("errors")
      expect(page).not_to have_content("fix")
    end

    scenario "scenario with invalid data" do
      log_in_as(user)

      visit sources_path

      click_on "new source"

      fill_in "Name", with: ""

      click_on "Create source"

      expect(page).to have_content("Yikes!")
      expect(page).to have_content("error")
      expect(page).to have_content("fix")
      expect(UserSource.count).to eq(0)
      expect(Source.count).to eq(0)
      expect(page).not_to have_content("You successfully created a new source!")
    end
  end
end
