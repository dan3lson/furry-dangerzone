require 'rails_helper'

feature "user creates feedback", %{

  As a user,
  I want to give feedback
  on Leksi.
} do

  # Acceptance Criteria
  #
  # [] I can visit the menu page
  #     and see two forms: one
	#     for Wish and Bugs
  # [] I can see a success-message

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

			within(".feedback-form-container-bug") do
	      fill_in "Description", with: "I wish once upon a star..."
			end

			within(".feedback-form-container-bug") do
      	click_on "submit"
			end

      expect(page).to have_content("Thanks for giving feedback!")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("error")
      expect(Feedback.count).to eq(1)
    end

    scenario "scenario: with invalid data" do
      log_in_as(user)

      visit menu_path

			within(".feedback-form-container-wish") do
	      fill_in "Description", with: ""
			end

			within(".feedback-form-container-wish") do
      	click_on "submit"
			end

      expect(page).to have_content("Yikes!")
      expect(page).to have_content("error")
			expect(page).not_to have_content("Thanks for giving feedback!")
      expect(Feedback.count).to eq(0)
    end

    scenario "scenario: user gives multiple feedback" do
      log_in_as(user)

      visit menu_path

			within(".feedback-form-container-wish") do
	      fill_in "Description", with: "Feedback uno"
			end

			within(".feedback-form-container-wish") do
      	click_on "submit"
			end

			within(".feedback-form-container-wish") do
	      fill_in "Description", with: "Feedback dos"
			end

			within(".feedback-form-container-wish") do
      	click_on "submit"
			end

      expect(page).to have_content("Thanks for giving feedback!")
      expect(Feedback.count).to eq(2)
    end
  end
end
