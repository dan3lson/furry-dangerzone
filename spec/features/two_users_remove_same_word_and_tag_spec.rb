require 'rails_helper'

feature "two users remove same word and tag", %{

  As user_1, I want to remove word_A and tag_A
  As user_2, I want to also remove
  word_A and tag_A
} do

  # Acceptance Criteria
  #
  # [x] As user_1 and user_2, I can see a
  #     "remove" button for the tag I want
  # [x] myTags doesn't show tag_A
  # [x] That /words/:id page doesn't show that tag
  # [x] I see a message of success

  describe "\n two users remove the same tag -->" do
    let!(:word) { FactoryGirl.create(:word) }
    let!(:source) { FactoryGirl.create(:source) }
    let!(:user_1) { FactoryGirl.create(:user) }
    let!(:user_2) { FactoryGirl.create(:user) }
    let!(:user_word_1) { UserWord.create(user: user_1, word: word) }
    let!(:user_word_2) { UserWord.create(user: user_2, word: word) }
    let!(:user_source_1) { UserSource.create(user: user_1, source: source) }
    let!(:user_source_2) { UserSource.create(user: user_2, source: source) }

    s = "scenario: "
    scenario s << "user_1 and user_2 remove same word (1st) and tag (2nd)" do
      log_in_as(user_1)

      click_on word.name

      click_on "remove"

      visit myTags_path

      click_on source.name

      click_on "remove"

      visit menu_path

      click_on "log out"

      log_in_as(user_2)

      click_on word.name

      click_on "remove"

      visit myTags_path

      click_on source.name

      click_on "remove"

      expect(Word.count).to eq(1)
      expect(Source.count).to eq(0)
      expect(UserWord.count).to eq(0)
      expect(UserSource.count).to eq(0)
      expect(WordSource.count).to eq(0)
      expect(UserWordSource.count).to eq(0)
    end

    s = "scenario: "
    scenario s << "user_1 and user_2 remove same tag (1st) and word (2nd)" do
      log_in_as(user_1)

      visit myTags_path

      click_on source.name

      click_on "remove"

      visit myLeksi_path

      click_on word.name

      click_on "remove"

      log_in_as(user_2)

      visit myTags_path

      click_on source.name

      click_on "remove"

      visit myLeksi_path

      click_on word.name

      click_on "remove"

      expect(Word.count).to eq(1)
      expect(Source.count).to eq(0)
      expect(UserWord.count).to eq(0)
      expect(UserSource.count).to eq(0)
      expect(WordSource.count).to eq(0)
      expect(UserWordSource.count).to eq(0)
    end
  end
end