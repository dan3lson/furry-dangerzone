require 'rails_helper'

feature "user visits home page", %{

  As a (logged in) user,
  I want to go to the Leksi.education homepage.
} do

  # Acceptance Criteria
  #
  # [x] I can visit /
  # [x] I see a game zone, progress, and
  #     tags section

  describe "\n visit home page -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let(:user_word) { FactoryGirl.create(:user_word) }
    let(:user) { user_word.user }
    let(:word) { user_word.word }

    scenario "scenario: myLeksi is displayed" do
      log_in_as(user)

      visit menu_path

      visit root_path

      expect(page).to have_content(word.name.capitalize)
      expect(page).to have_content("Home")
    end
  end
end
