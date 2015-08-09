require 'rails_helper'

feature "guest signs up", %{

  As a guest,
  I want to create my account.
} do

  # Acceptance Criteria
  #
  # [x] I can visit /signup
  # [x] I can see a form
  # [x] I see a button to create my account
  # [x] I can see errors if info isn't valid

  describe "\n guest signs up -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    scenario "scenario: with valid data" do
      visit root_path

      first(:link, "Get for free").click

      fill_in "Username", with: "FooFoo"
      fill_in "Password", with: "foobar"
      fill_in "Password Confirmation", with: "foobar"

      click_on "Create my account"

      expect(page).to have_content("Welcome to Leksi!")
      expect(page).to have_content("myLeksi is the place for all of your words")
      expect(page).to have_link("define")
      expect(page).to have_link("myTags")
      expect(page).to have_link("menu")
      expect(User.count).to eq(1)
      expect(page).to_not have_content("errors")
      expect(page).to_not have_content("fix")
    end

    scenario "scenario with invalid data" do
      visit root_path

      first(:link, "Get for free").click

      fill_in "Username", with: ""
      fill_in "Password", with: ""
      fill_in "Password Confirmation", with: ""

      click_on "Create my account"

      expect(page).to_not have_content("Welcome to Leksi!")
      expect(page).to have_content("errors")
      expect(page).to have_content("fix")
      expect(User.count).to eq(0)
    end
  end
end
