require 'rails_helper'

feature "user reviews app", %{

  As a user,
  I want to review Leksi
  on the latest version.
} do

  # Acceptance Criteria
  #
  # [x] I can visit the menu page
  #     and see a link to create
  #     a new review
  # [x] I see a review form
  # [x] I can see a success-message

  describe "\n user reviews app -->" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:version) { FactoryGirl.create(:version) }

    scenario "scenario: guest tries to review app" do
      visit new_version_review_path(version)

      expect(page).to have_content("Yikes! Please log in first to do that.")
      expect(page).to have_link("Log in")
      expect(page).not_to have_content("New Review")
    end

    scenario "scenario: with valid data (both rating and description)" do
      log_in_as(user)

      visit menu_path

      click_on "Rate this app"

      select "5", from: "Rating"

      fill_in "Description", with: "Dope app!"

      click_on "submit"

      expect(page).to have_content("Thanks for reviewing Leksi Version ")
      expect(page).to have_content("Reviews")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("error")
      expect(Review.count).to eq(1)
    end

    scenario "scenario: with valid data (just rating)" do
      log_in_as(user)

      visit menu_path

      click_on "Rate this app"

      select "5", from: "Rating"

      click_on "submit"

      expect(page).to have_content("Thanks for reviewing Leksi Version ")
      expect(page).to have_content("Reviews")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("error")
      expect(Review.count).to eq(1)
    end

    scenario "scenario: with invalid data" do
      log_in_as(user)

      visit menu_path

      click_on "Rate this app"

      click_on "submit"

      expect(page).to have_content(
        "Please select a rating before clicking \'submit\'."
      )
      expect(page).not_to have_content("Thanks for reviewing Leksi Version ")
      expect(page).not_to have_content("Reviews")
      expect(Review.count).to eq(0)
    end

    scenario "scenario: user tries to review version \'foo\' twice" do
      Review.create(user: user, rating: 5, version: version)

      log_in_as(user)

      visit menu_path

      expect(page).to have_content(
        "Thanks for reviewing the current Leksi version!"
      )
      expect(page).not_to have_content("New Review")
      expect(page).not_to have_link("submit")
      expect(page).not_to have_css("form")
      expect(Review.count).to eq(1)
    end

    scenario "scenario: user reviews version \'foo\' and then \'foo-bar\'" do
      Review.create(user: user, rating: 5, version: version)

      Version.create(number: "2.0.0", description: "added gamification")

      log_in_as(user)

      visit menu_path

      click_on "Rate this app"

      select "5", from: "Rating"

      click_on "submit"

      expect(page).to have_content("Thanks for reviewing Leksi Version ")
      expect(page).to have_content("Reviews")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("error")
      expect(Version.count).to eq(2)
      expect(Review.count).to eq(2)
    end
  end
end
