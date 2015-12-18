require 'rails_helper'

feature "user creates feedback", %{

  As a user,
  I want to give feedback
  on Leksi.
} do

  # Acceptance Criteria
  #
  # [x] I can visit the menu page,
  #     then to the feedbacks page,
	#     and see a form to submit
  # [x] I can see a success-message

  describe "\n user gives app feedback -->" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:version) { FactoryGirl.create(:version) }

    scenario "scenario: guest tries to give app feedback" do
      visit menu_path

      expect(page).to have_content("Yikes! Please log in first to do that.")
      expect(page).to have_link("Log in")
      expect(page).not_to have_content("New Feedback")
      expect(Feedback.count).to eq(0)
    end

    scenario "scenario: with valid data" do
      log_in_as(user)

      visit menu_path

      click_on "Report a problem"

      fill_in "Description", with: "Ewww...I saw a bug!"

    	click_on "submit"

      expect(page).to have_content("Thanks for giving feedback!")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("error")
      expect(Feedback.count).to eq(1)
    end

    scenario "scenario: with invalid data" do
      log_in_as(user)

      visit menu_path

      click_on "I wish Leksi could..."

      fill_in "Description", with: ""

    	click_on "submit"

      expect(page).to have_content("Yikes!")
      expect(page).to have_content("error")
			expect(page).not_to have_content("Thanks for giving feedback!")
      expect(Feedback.count).to eq(0)
    end
  end
end
