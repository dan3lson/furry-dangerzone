require 'rails_helper'

feature "user adds a word", %{

  As a user,
  I want to add a word to myLeksi.
} do

  # Acceptance Criteria
  #
  # [x] I can see an "add" button for the
  #     word I want
  # [x] myLeksi shows my newly added word
  # [x] I see a message of success

  describe "\n user adds a word" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:word) { FactoryGirl.create(:word) }

    scenario "scenario: logs out" do
      log_in_as(user)

      visit search_path

      fill_in "Search", with: "foobar"

      click_on "define"

      click_on "add"

      expect(page).to have_content("Awesome - you added #{word.name}!")
      expect(page).to have_content(word.name)
      expect(page).to have_content(word.definition)
      expect(page).to have_content(word.part_of_speech)
      expect(page).to have_content(word.pronunciation)
    end
  end
end
