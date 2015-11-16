require 'rails_helper'

feature "user changes weekly goal", %{

  As a user,
  I want to change how many
  words I want to master
  on a weekly basis.
} do

  # Acceptance Criteria
  #
  # [x] I can visit /mygoal or click
  #     the "edit goal" button
  # [x] I can see radio button options
  # [x] I can see a submit button
  # [x] I can see success message and
  #     the update reflected on Home

  pending "\n changes weekly goal option -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let(:user) { FactoryGirl.create(:user) }

    scenario "scenario: choose 1 word" do
      log_in_as(user)

      click_on "edit weekly goal"

      choose "weekly_goal_1"

      click_on "Save changes"

      expect(page).to have_content("Weekly Goal Settings")
      expect(page).to have_content("Success!")
    end

    scenario "scenario: choose 1 word and see it on the home page" do
      log_in_as(user)

      click_on "edit weekly goal"

      choose "weekly_goal_1"

      click_on "Save changes"

      visit root_path

      expect(page).to have_content("1 word")
    end

    scenario "scenario: choose 5 words" do
      log_in_as(user)

      click_on "edit weekly goal"

      choose "weekly_goal_5"

      click_on "Save changes"

      expect(page).to have_content("Weekly Goal Settings")
      expect(page).to have_content("Success!")
    end

    scenario "scenario: choose 5 words and see it on the home page" do
      log_in_as(user)

      click_on "edit weekly goal"

      choose "weekly_goal_5"

      click_on "Save changes"

      visit root_path

      expect(page).to have_content("5 words")
    end

    scenario "scenario: choose 10 words" do
      log_in_as(user)

      click_on "edit weekly goal"

      choose "weekly_goal_10"

      click_on "Save changes"

      expect(page).to have_content("Weekly Goal Settings")
      expect(page).to have_content("Success!")
    end

    scenario "scenario: choose 10 words and see it on the home page" do
      log_in_as(user)

      click_on "edit weekly goal"

      choose "weekly_goal_10"

      click_on "Save changes"

      visit root_path

      expect(page).to have_content("10 words")
    end

    scenario "scenario: choose 20 words" do
      log_in_as(user)

      click_on "edit weekly goal"

      choose "weekly_goal_20"

      click_on "Save changes"

      expect(page).to have_content("Weekly Goal Settings")
      expect(page).to have_content("Success!")
    end

    scenario "scenario: choose 20 words and see it on the home page" do
      log_in_as(user)

      click_on "edit weekly goal"

      choose "weekly_goal_20"

      click_on "Save changes"

      visit root_path

      expect(page).to have_content("20 words")
    end

    scenario "scenario: choose 30 words" do
      log_in_as(user)

      click_on "edit weekly goal"

      choose "weekly_goal_30"

      click_on "Save changes"

      expect(page).to have_content("Weekly Goal Settings")
      expect(page).to have_content("Success!")
    end

    scenario "scenario: choose 30 words and see it on the home page" do
      log_in_as(user)

      click_on "edit weekly goal"

      choose "weekly_goal_30"

      click_on "Save changes"

      visit root_path

      expect(page).to have_content("30 words")
    end
  end
end
