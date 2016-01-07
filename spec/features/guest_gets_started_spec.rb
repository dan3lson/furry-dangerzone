require 'rails_helper'

feature "guest gets started", %{

  As a guest,
  I want to get started.
} do

  # Acceptance Criteria
  #
  # [x] I can see a form
  #     to select a goal
  # [x] I can see a continue button

  describe "\n guest clicks get started button -->", js: true do
    before :each do
      FactoryGirl.create(:version)
    end

    scenario "scenario: click get started button" do
      visit root_path

      first(".btn-custom-get-started").click

      expect(page).to have_css(".weekly-goal-form")
      expect(page).to have_content("Weekly Goal")
      expect(page).to have_content("Selecting a weekly goal will help you stay")
      expect(page).to have_content("Basic")
      expect(page).to have_content("Casual")
      expect(page).to have_content("Regular")
      expect(page).to have_content("Serious")
      expect(page).to have_content("Insane")
      expect(page).to have_button("Skip")
      expect(page).to have_button("Continue", disabled: true)
    end
  end
end
