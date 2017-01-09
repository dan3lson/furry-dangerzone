require 'rails_helper'

feature "user edits another users page", %{

  As a user, I visit the
  edit page of another user.
} do

  # Acceptance Criteria
  #
  # [x] I get redirected to the login_path
  # [x] I can see a friendly message

  describe "\n visit unathorized pages -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let(:user) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }

    scenario "scenario: guest visits an edit user page" do
      log_in_as(user)
      visit edit_user_path(user2)

      expect(page).to have_content("Access denied.")
    end
  end
end
