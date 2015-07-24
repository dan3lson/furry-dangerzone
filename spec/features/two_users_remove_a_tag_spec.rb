require 'rails_helper'

feature "two users remove a tag", %{

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
  # [x] As user_1 and user_2, I can see a "remove" button
  #     for the tag I want
  # [x] myTags doesn't show my removed tag
  # [x] That tag is no longer on any /words/:id page
  # [x] I see a message of removal-success

  describe "\n two users remove the same tag -->" do
    let!(:word) { FactoryGirl.create(:word) }
    let!(:source) { FactoryGirl.create(:source) }
    let!(:user_1) { FactoryGirl.create(:user) }
    let!(:user_2) { FactoryGirl.create(:user) }
    let!(:user_word_1) { UserWord.create(user: user_1, word: word) }
    let!(:user_word_3) { UserWord.create(user: user_2, word: word) }
    let!(:user_source_1) { UserSource.create(user: user_1, source: source) }
    let!(:user_source_2) { UserSource.create(user: user_2, source: source) }
    let!(:word_source) { WordSource.create(word: word, source: source) }

    scenario "scenario: user_1 and user_2 remove same tag w/o words" do
      log_in_as(user_1)

      visit myTags_path

      click_on source.name

      click_on "remove"

      visit menu_path

      click_on "log out"

      log_in_as(user_2)

      visit myTags_path

      click_on source.name

      click_on "remove"

      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(2)
      expect(Source.count).to eq(0)
      expect(UserSource.count).to eq(0)
      expect(WordSource.count).to eq(0)
      expect(UserWordSource.count).to eq(0)
    end

    scenario "scenario: user_1 and user_2 remove same tag that has one word" do
      user_word_source_1 = UserWordSource.create(
        user: user_1, word_source: word_source
      )
      user_word_source_2 = UserWordSource.create(
        user: user_2, word_source: word_source
      )

      log_in_as(user_1)

      visit myTags_path

      click_on source.name

      within ".header-buttons" do
        click_on "remove"
      end

      visit menu_path

      click_on "log out"

      log_in_as(user_2)

      visit myTags_path

      click_on source.name

      within ".header-buttons" do
        click_on "remove"
      end

      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(2)
      expect(Source.count).to eq(0)
      expect(UserSource.count).to eq(0)
      expect(WordSource.count).to eq(0)
      expect(UserWordSource.count).to eq(0)
    end

    scenario "scenario: user_1 and user_2 remove tag with two words" do
      word_2 = FactoryGirl.create(:word, name: "foo")
      word_source_2 = WordSource.create(word: word_2, source: source)
      user_word_2 = UserWord.create(user: user_1, word: word_2)
      user_word_4 = UserWord.create(user: user_2, word: word_2)

      user_word_source_1 = UserWordSource.create(
        user: user_1, word_source: word_source
      )
      user_word_source_2 = UserWordSource.create(
        user: user_1, word_source: word_source_2
      )
      user_word_source_3 = UserWordSource.create(
        user: user_2, word_source: word_source
      )
      user_word_source_4 = UserWordSource.create(
        user: user_2, word_source: word_source_2
      )

      log_in_as(user_1)

      visit myTags_path

      click_on source.name

      within ".header-buttons" do
        click_on "remove"
      end

      visit menu_path

      click_on "log out"

      log_in_as(user_2)

      visit myTags_path

      click_on source.name

      within ".header-buttons" do
        click_on "remove"
      end

      expect(Word.count).to eq(2)
      expect(UserWord.count).to eq(4)
      expect(Source.count).to eq(0)
      expect(UserSource.count).to eq(0)
      expect(WordSource.count).to eq(0)
      expect(UserWordSource.count).to eq(0)
    end
  end
end
