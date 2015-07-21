require 'rails_helper'

feature "user adds source to a word", %{

  As a user,
  I already created a source
  and want to add a source to a word
  in myLeksi.
} do

  # Acceptance Criteria
  #
  # [x] I see a Tags section for one of my words
  # [x] I can select a source for that word
  # [x] I see a message of success

  describe "\n user adds a word -->" do
    let(:user_source) { FactoryGirl.create(:user_source) }
    let(:user) { user_source.user }
    let!(:word) { FactoryGirl.create(:word) }

    before :each do
      source = Source.find_by(name: "Untagged")
      user.sources << source
    end

    scenario "scenario: valid process" do
      user.words << word

      log_in_as(user)

      visit myLeksi_path

      click_on word.name

      select user_source.source.name, from: "Sources"

      click_on "add"

      expect(page).to have_content("Awesome - you tagged")
      expect(page).to have_content("to 'chess'!")
      expect(page).not_to have_content("Yikes!")
      expect(WordSource.count).to eq(1)
    end

    scenario "scenario: invalid process" do
      user.words << word

      log_in_as(user)

      visit myLeksi_path

      click_on word.name

      click_on "add"

      expect(page).not_to have_content("Awesome - you tagged")
      expect(page).not_to have_content("to 'chess'!")
      expect(page).to have_content(
        "Please select a tag before clicking \'add\'."
      )
      expect(WordSource.count).to eq(0)
    end
  end
end
