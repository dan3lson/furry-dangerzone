require 'rails_helper'

feature "user deletes source", %{

  As a user,
  I want to delete a source.
} do

  # Acceptance Criteria
  #
  # [] I can see a "delete" button
  # [] I see a message of success

  describe "\n user deletes source" do
    let(:user) { FactoryGirl.create(:user) }
    let(:source) { FactoryGirl.create(:source) }

    # need to make all associated words
    # go to Unsourced source
    pending "scenario: delete source" do
      log_in_as(user)

      visit sources_path

      click_on source.name

      click_on "Delete"

      expect(page).to have_content("Source deleted.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(Source.count).to eq(0)
    end
  end
end
