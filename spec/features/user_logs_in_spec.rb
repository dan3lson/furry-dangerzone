require 'rails_helper'

feature "user logs in", %{

  As a user,
  I want to log into Leksi.
} do

  # Acceptance Criteria
  #
  # [x] I can visit /login
  # [x] I can complete a form for user info
  # [x] I see errors on the page if fields
  #     are left blank
  # [x] Submitting the form takes me Home

  describe "user logs in -->" do
    let(:user) { FactoryGirl.create(:user) }

    scenario "scenario: input is valid (with email)" do
      visit login_path

      fill_in "Email or Username", with: user.email
      fill_in "Password", with: user.password

      within ".form-signin" do
        click_on "Log in"
      end

      expect(page).to have_content("Home")
      expect(page).to have_content("myLeksi")
      expect(page).to have_link("Add")
      expect(page).to have_link("Tags")
      expect(page).to have_link("Menu")

      msg = "Yikes! That username/password combination didn\'t work. "
      msg_2 = "Please try again."

      expect(page).not_to have_content(msg << msg_2)
    end

    scenario "scenario: input is valid (with username)" do
      visit login_path

      fill_in "Email or Username", with: user.username
      fill_in "Password", with: user.password

      within ".form-signin" do
        click_on "Log in"
      end

      expect(page).to have_content("Home")
      expect(page).to have_content("myLeksi")
      expect(page).to have_link("Add")
      expect(page).to have_link("Tags")
      expect(page).to have_link("Menu")

      msg = "Yikes! That username/password combination didn\'t work. "
      msg_2 = "Please try again."

      expect(page).not_to have_content(msg << msg_2)
    end

    scenario "scenario: input is valid (with username/no previous email)" do
      user.email = nil
      user.save

      visit login_path

      fill_in "Email or Username", with: user.username
      fill_in "Password", with: user.password

      within ".form-signin" do
        click_on "Log in"
      end

      expect(page).to have_content("Home")
      expect(page).to have_content("myLeksi")
      expect(page).to have_link("Add")
      expect(page).to have_link("Tags")
      expect(page).to have_link("Menu")

      msg = "Yikes! That username/password combination didn\'t work. "
      msg_2 = "Please try again."

      expect(page).not_to have_content(msg << msg_2)
    end

    scenario "scenario: input is invalid" do
      visit login_path

      fill_in "Email or Username", with: ""
      fill_in "Password", with: ""

      within ".form-signin" do
        click_on "Log in"
      end

      msg = "Yikes! That username/password combination didn\'t work. "
      msg_2 = "Please try again."

      expect(page).to have_content(msg << msg_2)
      expect(page).not_to have_content("Home")
      expect(page).not_to have_content("myLeksi")
      expect(page).not_to have_link("Add")
      expect(page).not_to have_link("Tags")
      expect(page).not_to have_link("Menu")
    end
  end
end
