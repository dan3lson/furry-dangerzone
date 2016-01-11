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
      FactoryGirl.create(:word)
      FactoryGirl.create(:word, name: "chess_2")
      FactoryGirl.create(:word, name: "chess_3")
      FactoryGirl.create(:word, name: "chess_4")
      FactoryGirl.create(:word, name: "chess_5")
    end

    scenario "scenario: from get_started with complete valid data" do
      visit root_path

      first(".btn-custom-get-started").click

      visit signup_path

      fill_in "Email", with: "foobar@foobar.com"
      fill_in "Username", with: "FooFoo"
      fill_in "Password", with: "foobar"
      fill_in "Password Confirmation", with: "foobar"

      click_on "Sign Up"

      expect(page).to have_content("Welcome to Leksi!")
      expect(page).to have_link("Add")
      expect(page).to have_link("Tags")
      expect(page).to have_link("Menu")
      expect(User.count).to eq(1)
      expect(User.first.num_logins).to eq(1)
      expect(UserWord.count).to eq(5)
      expect(page).to_not have_content("errors")
      expect(page).to_not have_content("fix")
    end

    scenario "scenario: with only required data" do
      visit root_path

      first(".btn-custom-get-started").click

      visit signup_path

      fill_in "Email", with: "foobar@foobar.com"
      fill_in "Username", with: "FooFoo"
      fill_in "Password", with: "foobar"
      fill_in "Password Confirmation", with: "foobar"

      click_on "Sign Up"

      expect(page).to have_content("Welcome to Leksi!")
      expect(page).to have_link("Add")
      expect(page).to have_link("Tags")
      expect(page).to have_link("Menu")
      expect(User.count).to eq(1)
      expect(User.first.num_logins).to eq(1)
      expect(UserWord.count).to eq(5)
      expect(page).to_not have_content("errors")
      expect(page).to_not have_content("fix")
    end

    scenario "scenario with invalid data" do
      visit signup_path

      fill_in "Email", with: ""
      fill_in "Username", with: ""
      fill_in "Password", with: ""
      fill_in "Password Confirmation", with: ""

      click_on "Sign Up"

      expect(page).to have_content("errors")
      expect(page).to have_content("fix")
      expect(User.count).to eq(0)
      expect(UserWord.count).to eq(0)
    end
  end
end
