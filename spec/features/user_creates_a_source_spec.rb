require 'rails_helper'

feature "user creates a source", %{

  As a user,
  I want to create a source.
} do

  # Acceptance Criteria
  #
  # [] I can see a form to add a source
  # [] sources_path shows my newly added source
  # [] I see a message of success

  describe "\n user creates a source" do
    let(:user) { FactoryGirl.create(:user) }

    pending "scenario: with valid data" do
      log_in_as(user)

      create_source

      expect(page).to have_content("You successfully added a source!")
      expect(Source.count).to eq(1)
      expect(page).to_not have_content("Yikes!")
      expect(page).to_not have_content("errors")
      expect(page).to_not have_content("fix")
    end

    pending "scenario with invalid data" do
      log_in_as(user)

      visit sources_path

      click_on "add"

      fill_in "Name", with: ""

      click_on "Create sourcs"

      expect(page).to have_content("Yikes!")
      expect(page).to have_content("errors")
      expect(page).to have_content("fix")
      expect(Source.count).to eq(0)
      expect(page).not_to have_content("You successfully added a source!")
    end
  end
end
