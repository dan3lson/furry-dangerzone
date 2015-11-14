require 'rails_helper'

feature "user views weekly goal options", %{

  As a user,
  I want to see a form for
  changing how many words
  I master weekly.
} do

  # Acceptance Criteria
  #
  # [x] I can visit /mygoal or click
  #     the "edit goal" button
  # [x] I can see radio button options
  # [x] I can see a submit button

  pending "\n views weekly goal option -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let(:user) { FactoryGirl.create(:user) }

    scenario "scenario: from root_path" do
      log_in_as(user)

      click_on "edit weekly goal"

      expect(page).to have_css(".weekly-goal-form")
      expect(page).to have_content("Weekly Goal")
      expect(page).to have_content("Selecting a weekly goal will help you stay")
      expect(page).to have_content("Basic")
      expect(page).to have_content("Casual")
      expect(page).to have_content("Regular")
      expect(page).to have_content("Serious")
      expect(page).to have_content("Insane")
      expect(page).to have_button("Save changes")
    end

    scenario "scenario: from /weekly_goal" do
      log_in_as(user)

      visit "/weekly_goal"

      expect(page).to have_css(".weekly-goal-form")
      expect(page).to have_content("Weekly Goal")
      expect(page).to have_content("Selecting a weekly goal will help you stay")
      expect(page).to have_content("Basic")
      expect(page).to have_content("Casual")
      expect(page).to have_content("Regular")
      expect(page).to have_content("Serious")
      expect(page).to have_content("Insane")
      expect(page).to have_button("Save changes")
    end

    scenario "scenario: guest tries to access weekly_goal" do
      visit "/weekly_goal"

      expect(page).not_to have_css(".weekly-goal-form")
      expect(page).not_to have_content("Weekly Goal")
      expect(page).not_to have_content("Selecting a weekly goal will help you stay")
      expect(page).not_to have_content("Basic")
      expect(page).not_to have_content("Casual")
      expect(page).not_to have_content("Regular")
      expect(page).not_to have_content("Serious")
      expect(page).not_to have_content("Insane")
      expect(page).not_to have_button("Save changes")
      expect(page).to have_content("Yikes! Please log in first to do that.")
    end

    scenario "scenario: guest tries to access weekly_goal" do
      visit weekly_goal_path

      expect(page).not_to have_css(".weekly-goal-form")
      expect(page).not_to have_content("Weekly Goal")
      expect(page).not_to have_content("Selecting a weekly goal will help you stay")
      expect(page).not_to have_content("Basic")
      expect(page).not_to have_content("Casual")
      expect(page).not_to have_content("Regular")
      expect(page).not_to have_content("Serious")
      expect(page).not_to have_content("Insane")
      expect(page).not_to have_button("Save changes")
      expect(page).to have_content("Yikes! Please log in first to do that.")
    end
  end
end
