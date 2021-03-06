require 'rails_helper'

feature "two users remove a word", %{

  As user_1, I want to remove an untagged
  and / or tagged word from myLeksi.
  As user_2, I have that same word and
  don't want myLeksi and myTags to be
  changed because of what user_1 did.
  As user_2, I also want to remove that
  same tagged word.
} do

  # Acceptance Criteria
  #
  # [x] As user_1, I can see a "remove" button
  #     for the word I want
  # [x] As user_2, I can also see a "remove" button
  #     for that same word user_1 has
  # [x] myLeksi doesn't show the removed word
  # [x] That word is no longer on myTags page
  # [x] I see a message of removal-success

  describe "\n two users remove a word -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let!(:user_word) { FactoryGirl.create(:user_word) }
    let!(:word) { user_word.word }
    let!(:user_1) { user_word.user }
    let!(:user_2) { FactoryGirl.create(:user) }
    let!(:user_word_2) { UserWord.create(word: word, user: user_2) }

    scenario "scenario: user_1 removes untagged word (not tagged for user_2)" do
      log_in_as(user_1)

      visit notebook_path

      click_on word.name.capitalize

      click_on "remove"

      expect(page).to have_content("has been removed.")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("foo-bar")
      expect(page).not_to have_content("lorem ipsum")
      expect(page).not_to have_content("noun")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(1)
      expect(UserWordTag.count).to eq(0)
    end

    scenario "scenario: user_1 removes tagged word (not tagged for user_2)" do
      user_tag = FactoryGirl.create(:user_tag, user: user_1)
      tag = user_tag.tag
      user_word_tag = UserWordTag.create(
        user: user_1, word_tag: word_tag
      )

      log_in_as(user_1)

      visit notebook_path

      click_on word.name.capitalize

      within ".header-buttons" do
        click_on "remove"
      end

      expect(page).to have_content("has been removed.")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("foo-bar")
      expect(page).not_to have_content("lorem ipsum")
      expect(page).not_to have_content("noun")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(1)
      expect(UserWordTag.count).to eq(0)
    end

    scenario "scenario: user_1 removes tagged word (also tagged for user_2)" do
      user_tag = FactoryGirl.create(:user_tag, user: user_1)
      tag = user_tag.tag
      user_tag_2 = UserTag.create(tag: tag, user: user_2)
      user_word_tag = UserWordTag.create(
        user: user_1, word_tag: word_tag
      )
      user_word_tag = UserWordTag.create(
        user: user_2, word_tag: word_tag
      )

      log_in_as(user_1)

      visit notebook_path

      click_on word.name.capitalize

      within ".header-buttons" do
        click_on "remove"
      end

      expect(page).to have_content("has been removed.")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("foo-bar")
      expect(page).not_to have_content("lorem ipsum")
      expect(page).not_to have_content("noun")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(1)
      expect(UserWordTag.count).to eq(1)
    end

    scenario "scenario: user_1 and user_2 remove the same tagged word" do
      user_tag = FactoryGirl.create(:user_tag, user: user_1)
      tag = user_tag.tag
      user_tag_2 = UserTag.create(tag: tag, user: user_2)
      user_word_tag = UserWordTag.create(
        user: user_1, word_tag: word_tag
      )
      user_word_tag = UserWordTag.create(
        user: user_2, word_tag: word_tag
      )

      log_in_as(user_1)

      visit notebook_path

      click_on word.name.capitalize

      within ".header-buttons" do
        click_on "remove"
      end

      visit settings_path

      click_on "Log out"

      log_in_as(user_2)

      visit notebook_path

      click_on word.name.capitalize

      within ".header-buttons" do
        click_on "remove"
      end

      expect(page).to have_content("has been removed.")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("foo-bar")
      expect(page).not_to have_content("lorem ipsum")
      expect(page).not_to have_content("noun")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end
  end
end
