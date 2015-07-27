require 'rails_helper'

feature "two users add same word and tag", %{

  As user_1, I want to add word_A
  and tag it to tag_A
  As user_2, I want to also add
  word_A and tag it to tag_A
} do

  # Acceptance Criteria
  #
  # [x] As user_1 and user_2, I can see an "add" button
  #     for the tag I want
  # [x] myTags shows my tag with one count
  # [x] That /words/:id page shows the tag
  # [x] I see a message of success

  describe "\n two users remove the same tag -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let!(:word) { FactoryGirl.create(:word) }
    let!(:tag) { FactoryGirl.create(:tag) }
    let!(:user_1) { FactoryGirl.create(:user) }
    let!(:user_2) { FactoryGirl.create(:user) }
    let!(:user_word_1) { UserWord.create(user: user_1, word: word) }
    let!(:user_word_2) { UserWord.create(user: user_2, word: word) }
    let!(:user_tag_1) { UserTag.create(user: user_1, tag: tag) }
    let!(:user_tag_2) { UserTag.create(user: user_2, tag: tag) }

    scenario "scenario: user_1 and user_2 add/apply same word and tag" do
      log_in_as(user_1)

      click_on word.name

      select user_tag_2.tag.name, from: "Tags"

      click_on "add"

      visit menu_path

      click_on "Log Out"

      log_in_as(user_2)

      click_on word.name

      select user_tag_2.tag.name, from: "Tags"

      click_on "add"

      expect(Word.count).to eq(1)
      expect(Tag.count).to eq(1)
      expect(UserWord.count).to eq(2)
      expect(UserTag.count).to eq(2)
      expect(WordTag.count).to eq(1)
      expect(UserWordTag.count).to eq(2)
    end
  end
end
