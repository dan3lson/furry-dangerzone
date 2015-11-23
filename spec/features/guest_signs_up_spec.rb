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

    scenario "scenario: with complete valid data" do
      visit root_path

      first(:link, "Get started").click

      fill_in "Username", with: "FooFoo"
      fill_in "First Name", with: "FIrstFooFoo"
      fill_in "Last Name", with: "LastFooFoo"
      fill_in "Email", with: "foobar@foobar.com"
      fill_in "Password", with: "foobar"
      fill_in "Password Confirmation", with: "foobar"

      click_on "Create my account"

      expect(page).to have_content("Welcome to Leksi!")
      expect(page).to have_content("Organize words into groups by using tags.")
      expect(page).to have_link("Add")
      expect(page).to have_link("Stats")
      expect(page).to have_link("Menu")
      expect(User.count).to eq(1)
      expect(User.first.num_logins).to eq(1)
      expect(page).to_not have_content("errors")
      expect(page).to_not have_content("fix")
    end

    scenario "scenario: with only required valid data" do
      visit root_path

      first(:link, "Get started").click

      fill_in "Username", with: "FooFoo"
      fill_in "Password", with: "foobar"
      fill_in "Password Confirmation", with: "foobar"

      click_on "Create my account"

      expect(page).to have_content("Welcome to Leksi!")
      expect(page).to have_content("Organize words into groups by using tags.")
      expect(page).to have_link("Add")
      expect(page).to have_link("Stats")
      expect(page).to have_link("Menu")
      expect(User.count).to eq(1)
      expect(User.first.num_logins).to eq(1)
      expect(page).to_not have_content("errors")
      expect(page).to_not have_content("fix")
    end

    scenario "scenario with invalid data" do
      visit root_path

      first(:link, "Get started").click

      fill_in "Username", with: ""
      fill_in "Password", with: ""
      fill_in "Password Confirmation", with: ""

      click_on "Create my account"

      expect(page).to_not have_content("Organize words into groups by using")
      expect(page).to have_content("errors")
      expect(page).to have_content("fix")
      expect(User.count).to eq(0)
    end
  end
end
