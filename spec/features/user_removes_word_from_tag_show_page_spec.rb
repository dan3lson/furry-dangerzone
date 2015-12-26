require 'rails_helper'

feature "user removes word from tag show page", %{

  As a user,
  I want to remove a word
  from the tag's index
  container.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "remove" button
  # [x] That word is no longer on /tags/:id
  #     but still is a word I have in myLeksi
  # [x] I see a message of removal-success

  describe "\n user removes word from tag -->" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:word_1) { FactoryGirl.create(:word) }
    let!(:tag) { FactoryGirl.create(:tag) }
    let!(:user_tag) { UserTag.create(user: user, tag: tag) }
    let!(:user_word_1) { UserWord.create(user: user, word: word_1) }
    let!(:word_tag_1) { WordTag.create(word: word_1, tag: tag) }
    let!(:user_word_tag_1) { UserWordTag.create(
      user: user, word_tag: word_tag_1)
    }

    scenario "scenario: remove one word from tag show page" do
      log_in_as(user)

      visit myTags_path

      find(".word-on-tag-show-page-remove-btn").click

      expect(page).to have_content("Success")
      expect(page).not_to have_content("Yikes!")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(1)
      expect(Tag.count).to eq(1)
      expect(UserTag.count).to eq(1)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end

    scenario "scenario: remove one of two words from tag show page" do
      word_2 = FactoryGirl.create(:word, name: "chess_2")
      UserWord.create(user: user, word: word_2)
      word_tag_2 = WordTag.create(word: word_2, tag: tag)
      UserWordTag.create(
        user: user, word_tag: word_tag_2
      )

      log_in_as(user)

      visit myTags_path

      first(".word-on-tag-show-page-remove-btn").click

      expect(page).to have_content("Success")
      expect(page).not_to have_content("Yikes!")
      expect(Word.count).to eq(2)
      expect(UserWord.count).to eq(2)
      expect(Tag.count).to eq(1)
      expect(UserTag.count).to eq(1)
      expect(WordTag.count).to eq(1)
      expect(UserWordTag.count).to eq(1)
    end
  end
end
