require 'rails_helper'

feature "user selects weekly goal", %{

  As a user,
  I want to select how many
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

  pending "\n selects weekly goal -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let(:user) { FactoryGirl.create(:user) }

    scenario "scenario: select goal from root_path" do
      log_in_as(user)

      click_on "edit weekly goal"

      expect(page).to have_css(".weekly-goal-form")
      expect(page).to have_content("Weekly Goal")
      expect(page).to have_content("Select how many words you want to learn")
      expect(page).to have_content("Basic")
      expect(page).to have_content("Casual")
      expect(page).to have_content("Regular")
      expect(page).to have_content("Serious")
      expect(page).to have_content("Insane")
      expect(page).to have_link("Save changes")
    end
  end
end
