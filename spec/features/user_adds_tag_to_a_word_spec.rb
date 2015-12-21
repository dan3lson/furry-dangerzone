require 'rails_helper'

feature "user adds tag to a word", %{

  As a user,
  I already created a tag
  and want to add a tag to a word
  on the word\'s show page.
} do

  # Acceptance Criteria
  #
  # [x] I see a Tags section for one of my words
  # [x] I can select and add a tag for that word
  # [x] I see a message of success

  pending "\n user adds a tag to a word -->" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:word) { FactoryGirl.create(:word) }
    let!(:tag) { FactoryGirl.create(:tag) }
    let!(:user_word) { UserWord.create(user: user, word: word) }
    let!(:user_tag) { UserTag.create(user: user, tag: tag) }

    scenario "scenario: valid process", js: true do
      log_in_as(user)

      visit myLeksi_path

      click_on word.name.capitalize

      select user_tag.tag.name, from: "Tags"

      click_on "Learn"

      expect(page).to have_content("Success!")
      expect(page).not_to have_content("Yikes!")
      expect(WordTag.count).to eq(1)
      expect(UserWordTag.count).to eq(1)
    end

    scenario "scenario: invalid process", js: true do
      log_in_as(user)

      visit myLeksi_path

      click_on word.name.capitalize

      click_on "Learn"

      expect(page).not_to have_content("Success!")
      expect(page).to have_content(
        "Please select a tag before clicking \'add\'."
      )
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end
  end
end
