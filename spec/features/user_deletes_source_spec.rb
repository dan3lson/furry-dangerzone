require 'rails_helper'

feature "user deletes source", %{

  As a user,
  I want to delete a source.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "delete" button
  # [x] I see a message of deletion-success

  describe "\n user deletes source -->" do
    let(:user_source) { FactoryGirl.create(:user_source) }
    let(:source) { user_source.source }
    let(:user) { user_source.user }
    before :each do
      source = Source.find_by(name: "Untagged")
      user.sources << source
    end

    # need to make all associated words
    # go to Unsourced source
    scenario "scenario: delete source" do
      log_in_as(user)

      visit mySources_path

      click_on source.name

      click_on "remove"

      expect(page).to have_content("\'#{source.name}\' has been removed.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(Source.count).to eq(2)
      expect(UserSource.count).to eq(1)
    end
  end
end
