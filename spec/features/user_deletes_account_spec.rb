require 'rails_helper'

feature "user deletes (their (duh)) account", %{

  As a user,
  I want to delete my account.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "delete account" button
  # [x] I see a message of (sad) success

  describe "\n user deletes account -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    scenario "scenario: without words or tags" do
      user = FactoryGirl.create(:user)

      log_in_as(user)

      visit settings_path

      click_on "Edit"

      click_on "delete my account"

      expect(page).to have_content("Account deleted; it\'s sad to see you go.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(User.count).to eq(0)
    end

    scenario "scenario: just with tags" do
      user_tag = FactoryGirl.create(:user_tag)
      user = user_tag.user

      log_in_as(user)

      visit settings_path

      click_on "Edit"

      click_on "delete my account"

      expect(page).to have_content("Account deleted; it\'s sad to see you go.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(User.count).to eq(0)
      expect(UserTag.count).to eq(0)
    end

    scenario "scenario: with words and tags" do
      user_tag = FactoryGirl.create(:user_tag)
      user_word = FactoryGirl.create(:user_word)
      user = user_tag.user
      old_user = user_word.user
      user_word.user = user
      old_user.destroy

      log_in_as(user)

      visit settings_path

      click_on "Edit"

      click_on "delete my account"

      expect(page).to have_content("Account deleted; it\'s sad to see you go.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(User.count).to eq(0)
      expect(UserTag.count).to eq(0)
      expect(UserWord.count).to eq(0)
    end
  end
end
