require 'rails_helper'

feature "user deletes (their) account", %{

  As a user,
  I want to delete my account.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "delete account" button
  # [x] I see a message of success

  describe "\n user deletes account" do
    let(:user) { FactoryGirl.create(:user) }
    let(:word) { FactoryGirl.create(:word) }

    scenario "scenario: without words" do
      log_in_as(user)

      visit menu_path

      click_on "Delete My Account"

      expect(page).to have_content("Account deleted; it\'s sad to see you go.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(User.count).to eq(0)
    end

    pending "scenario: with words" do
      log_in_as(user)

      add_word

      visit menu_path

      click_on "Delete My Account"

      expect(page).to have_content("Account deleted; it\'s sad to see you go.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(User.count).to eq(0)
      expect(UserWord.count).to eq(0)
      expect(UserSource.count).to eq(0)
      expect(Source.count).to eq(0)
    end

    pending "scenario: with sources" do
      log_in_as(user)

      create_source

      visit menu_path

      click_on "Delete My Account"

      expect(page).to have_content("Account deleted; it\'s sad to see you go.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(User.count).to eq(0)
      expect(UserSource.count).to eq(0)
      expect(Source.count).to eq(0)
    end
  end
end
