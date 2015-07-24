require 'rails_helper'

feature "user removes tag from word show page", %{

  As a user,
  I want to remove a tag for
  one of my words from that
  word's show page.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "remove" button
  # [x] That tag is no longer on /words/:id
  #     but is a tag I still have in myTags
  # [x] I see a message of removal-success

  describe "\n user removes a tag -->" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:word) { FactoryGirl.create(:word) }
    let!(:source) { FactoryGirl.create(:source) }
    let!(:user_source) { UserSource.create(user: user, source: source) }
    let!(:user_word) { UserWord.create(user: user, word: word) }
    let!(:word_source) { WordSource.create(word: word, source: source) }
    let!(:user_word_source) { UserWordSource.create(
      user: user, word_source: word_source) }

    scenario "scenario: remove one tag from word show page" do
      log_in_as(user)

      click_on word.name

      within(".tag-on-word-show-page") do
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

    scenario "scenario: remove one of two tags from word show page" do
      source_2 = FactoryGirl.create(:source, name: "foo_bar_source")
      user_source_2 = UserSource.create(user: user, source: source_2)
      word_source_2 = WordSource.create(word: word, source: source_2)
      user_word_source = UserWordSource.create(
        user: user, word_source: word_source_2
      )

      log_in_as(user)

      click_on word.name

      within all(".tag-on-word-show-page").last do
        click_on "remove"
      end

      expect(page).to have_content("You removed \'")
      expect(page).not_to have_content("Yikes!")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(1)
      expect(Source.count).to eq(2)
      expect(UserSource.count).to eq(2)
      expect(WordSource.count).to eq(1)
      expect(UserWordSource.count).to eq(1)
    end
  end
end
