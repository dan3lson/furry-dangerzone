require 'rails_helper'

feature "users add the same source", %{

  As a user,
  I want to add a source
  that another use already added.
} do

  # Acceptance Criteria
  #
  # [x] I can see a form to add a source
  # [x] sources_path shows my newly added source
  # [x] I see a message of success

  describe "\n two users add a source -->" do
    let(:user) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }

    scenario "scenario: add word" do
      log_in_as(user)

      visit myTags_path

      click_on "new source"

      fill_in "Name", with: "foo"

      click_on "Create source"

      visit menu_path

      click_on "log out"

      log_in_as(user2)

      visit myTags_path

      click_on "new source"

      fill_in "Name", with: "foo"

      click_on "Create source"

      expect(page).to have_link("foo")
      expect(UserSource.count).to eq(2)
      expect(Source.count).to eq(2)
      expect(page).not_to have_content("Yikes!")
    end
  end
end
