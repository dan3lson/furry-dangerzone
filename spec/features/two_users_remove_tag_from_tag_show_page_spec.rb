require 'rails_helper'

feature "two users remove tag from tag show page", %{

  As user_1, I want to remove tag_A
  that could or could not have words.
  As user_2, I also have tag_A and
  don't want myLeksi and myTags to be
  changed because of what user_1 did.
  As user_2, I want to remove tag_A,
  which could or could not have other
  users or words.
} do

  # Acceptance Criteria
  #
  # [x] As user_1 and user_2, I can see a "remove tag" button
  #     for the tag I want
  # [x] myTags doesn't show my removed tag
  # [x] That tag is no longer on any /words/:id page
  # [x] I see a message of removal-success

  describe "\n two users remove the same tag -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let!(:user_1) { FactoryGirl.create(:user) }
    let!(:user_2) { FactoryGirl.create(:user) }
    let!(:word) { FactoryGirl.create(:word) }
    let!(:tag) { FactoryGirl.create(:tag) }
    let!(:user_word_1) { UserWord.create(user: user_1, word: word) }
    let!(:user_word_2) { UserWord.create(user: user_2, word: word) }
    let!(:user_tag_1) { UserTag.create(user: user_1, tag: tag) }
    let!(:user_tag_2) { UserTag.create(user: user_2, tag: tag) }

    scenario "scenario: user_1 and user_2 remove same tag w/o words" do
      log_in_as(user_1)

      visit myTags_path

      find(".my_tags-remove-btn").click

      visit settings_path

      click_on "Log out"

      log_in_as(user_2)

      visit myTags_path

      find(".my_tags-remove-btn").click

      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(2)
      expect(Tag.count).to eq(0)
      expect(UserTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end

    scenario "scenario: user_1 and user_2 remove same tag w/one word each" do
      UserWordTag.create(user: user_1, word_tag: word_tag)
      UserWordTag.create(user: user_2, word_tag: word_tag)

      log_in_as(user_1)

      visit myTags_path

      find(".my_tags-remove-btn").click

      visit settings_path

      click_on "Log out"

      log_in_as(user_2)

      visit myTags_path

      find(".my_tags-remove-btn").click

      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(2)
      expect(Tag.count).to eq(0)
      expect(UserTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end

    scenario "scenario: user_1 and user_2 remove tag w/two words each" do
      word_2 = FactoryGirl.create(:word, name: "googoo")

      user_word_3 = UserWord.create!(user: user_1, word: word_2)
      user_word_4 = UserWord.create!(user: user_2, word: word_2)


      user_word_tag_1 = UserWordTag.create(user: user_1, word_tag: word_tag)
      user_word_tag_2 = UserWordTag.create(user: user_1, word_tag: word_tag_2)
      user_word_tag_3 = UserWordTag.create(user: user_2, word_tag: word_tag)
      user_word_tag_4 = UserWordTag.create(user: user_2, word_tag: word_tag_2)

      log_in_as(user_1)

      visit myTags_path

      find(".my_tags-remove-btn").click

      visit settings_path

      click_on "Log out"

      log_in_as(user_2)

      visit myTags_path

      find(".my_tags-remove-btn").click

      expect(Word.count).to eq(2)
      expect(UserWord.count).to eq(4)
      expect(Tag.count).to eq(0)
      expect(UserTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end
  end
end
