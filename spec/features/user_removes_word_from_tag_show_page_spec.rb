require 'rails_helper'

feature "user removes word from tag show page", %{

  As a user,
  I want to remove a word for
  one of my tag from that
  tag's show page.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "remove" button
  # [x] That word is no longer on /tags/:id
  #     but still is a word I have in myLeksi
  # [x] I see a message of removal-success

  describe "\n user removes a tag -->" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:word_1) { FactoryGirl.create(:word) }
    let!(:source) { FactoryGirl.create(:source) }
    let!(:user_source) { UserSource.create(user: user, source: source) }
    let!(:user_word_1) { UserWord.create(user: user, word: word_1) }
    let!(:word_source_1) { WordSource.create(word: word_1, source: source) }
    let!(:user_word_source_1) { UserWordSource.create(
      user: user, word_source: word_source_1)
    }

    scenario "scenario: remove one word from tag show page" do
      log_in_as(user)

      visit myTags_path

      click_on source.name

      within ".word-on-tag-show-page" do
        click_on "remove"
      end

      expect(page).to have_content("You removed \'")
      expect(page).not_to have_content("Yikes!")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(1)
      expect(Source.count).to eq(1)
      expect(UserSource.count).to eq(1)
      expect(WordSource.count).to eq(0)
      expect(UserWordSource.count).to eq(0)
    end

    scenario "scenario: remove one of two words from tag show page" do
      word_2 = FactoryGirl.create(:word, name: "chess_2")
      user_word_2 = UserWord.create(user: user, word: word_2)
      word_source_2 = WordSource.create(word: word_2, source: source)
      user_word_source_2 = UserWordSource.create(
        user: user, word_source: word_source_2
      )

      log_in_as(user)

      visit myTags_path

      click_on source.name

      within all(".word-on-tag-show-page").last do
        click_on "remove"
      end

      expect(page).to have_content("You removed \'")
      expect(page).not_to have_content("Yikes!")
      expect(Word.count).to eq(2)
      expect(UserWord.count).to eq(2)
      expect(Source.count).to eq(1)
      expect(UserSource.count).to eq(1)
      expect(WordSource.count).to eq(1)
      expect(UserWordSource.count).to eq(1)
    end
  end
end
