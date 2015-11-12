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
  end
end
