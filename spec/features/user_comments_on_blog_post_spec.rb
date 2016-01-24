require 'rails_helper'

feature "user comments on blog post", %{

  As a user,
  I want to comment on a
  blog post.
} do

  # Acceptance Criteria
  #
  # [x] I see a form
  # [x] I see a submit button
  # [x] I see a results-message

  describe "\n user comments on blog post -->" do
    let!(:version) { FactoryGirl.create(:version) }
    let(:user) { FactoryGirl.create(:user) }

    scenario "scenario: guest completes form w/valid data" do
      visit blog_path

      click_on "All About Leksi, Part I: What's in a Name?"

      fill_in "Comment", with: "That\'s so clever! <3"
      # fill in recaptcha

      expect(page).to have_content("Success!")
      expect(page).not_to have_content("Yikes!")
      expect(comments.count).to eq(1)
    end

    scenario "scenario: guest completes form w/invalid data" do
      visit blog_path

      click_on "All About Leksi, Part I: What's in a Name?"

      fill_in "Comment", with: ""

      expect(page).to have_content("Yikes!")
      expect(page).not_to have_content("Success!")
      expect(comments.count).to eq(0)
    end

    scenario "scenario: user completes form w/valid data" do
      log_in_as(user)

      visit blog_path

      click_on "All About Leksi, Part I: What's in a Name?"
      # fill in recaptcha

      fill_in "Comment", with: "That\'s so clever! <3"

      expect(page).to have_content("Success!")
      expect(page).not_to have_content("Yikes!")
      expect(comments.count).to eq(1)
    end

    scenario "scenario: user completes form w/invalid data" do
      log_in_as(user)

      visit blog_path

      click_on "All About Leksi, Part I: What's in a Name?"

      fill_in "Comment", with: ""

      expect(page).to have_content("Yikes!")
      expect(page).not_to have_content("Success!")
      expect(comments.count).to eq(0)
    end
  end
end
