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

  describe "\n two users add same word and tag -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    scenario "scenario: user_1 and user_2 add/apply same word and tag" do
      user_1 = FactoryGirl.create(:user)
      user_2 = FactoryGirl.create(:user)

      word = FactoryGirl.create(:word)

      UserWord.create!(user: user_1, word: word)
      UserWord.create!(user: user_2, word: word)

      tag = FactoryGirl.create(:tag)

      user_tag_1 = UserTag.create!(user: user_1, tag: tag)
      user_tag_2 = UserTag.create!(user: user_2, tag: tag)

      log_in_as(user_1)

      visit notebook_path

      click_on word.name.capitalize

      select user_tag_1.tag.name, from: "Tags"

      click_on "add"

      visit settings_path

      click_on "Log out"

      log_in_as(user_2)

      visit notebook_path

      click_on word.name.capitalize

      select user_tag_2.tag.name, from: "Tags"

      click_on "add"

      expect(Word.count).to eq(1)
      expect(Tag.count).to eq(1)
      expect(UserWord.count).to eq(2)
      expect(UserTag.count).to eq(2)
      expect(UserWordTag.count).to eq(2)
    end
  end
end
