require 'rails_helper'

feature "user reviews app", %{

  As a user,
  I want to give review Leksi
  on the current version.
} do

  # Acceptance Criteria
  #
  # [x] I can visit /reviews/new
  # [x] I see a review form
  # [x] I can see a success-message

  describe "\n user reviews app -->" do
    let!(:user) { FactoryGirl.create(:user) }

    scenario "scenario: guest tries to review app" do
      visit new_version_review_path

      expect(page).to have_content("Yikes! Please log in first to do that.")
      expect(page).to have_content("Sign Up")
      expect(page).to have_link("Create my account")
      expect(page).not_to have_content("New Review")
    end

    scenario "scenario: user reviews app" do

    end

    scenario "scenario: user tries to review twice for same app version" do

    end

    scenario "scenario: user reviews again for new app version" do

    end
  end
end
