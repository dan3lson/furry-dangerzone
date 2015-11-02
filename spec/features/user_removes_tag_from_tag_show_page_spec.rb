require 'rails_helper'

feature "user removes tag from tag show page", %{

  As a user,
  I want to remove a tag from the
  tags/:id show page.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "remove" button
  # [x] I see a message of success

  describe "\n user removes tag -->" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:tag) { FactoryGirl.create(:tag) }
    let!(:user_tag) { UserTag.create!(user: user, tag: tag) }
    let(:word) { FactoryGirl.create(:word) }

    scenario "scenario: remove tag without words" do
      log_in_as(user)

      visit myTags_path

      click_on tag.name

      click_on "edit tag"

      click_on "remove tag"

      expect(page).to have_content("Success: \'#{tag.name}\' removed.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(Tag.count).to eq(0)
      expect(UserTag.count).to eq(0)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end

    scenario "scenario: remove tag with words" do
      UserWord.create(user: user, word: word)
      wt = WordTag.create(word: word, tag: tag)
      UserWordTag.create(user: user, word_tag: wt)

      log_in_as(user)

      visit myTags_path

      click_on tag.name

      click_on "edit tag"

      within ".header-buttons" do
        click_on "remove tag"
      end

      expect(page).to have_content("Success: \'#{tag.name}\' removed.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(1)
      expect(Tag.count).to eq(0)
      expect(UserTag.count).to eq(0)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end

    scenario "scenario: remove tag with words used by other users" do
      UserWord.create!(user: user, word: word)
      wt = WordTag.create!(word: word, tag: tag)
      UserWordTag.create!(user: user, word_tag: wt)

      user_2 = FactoryGirl.create(:user)
      UserWord.create!(user: user_2, word: word)
      UserTag.create!(user: user_2, tag: tag)
      UserWordTag.create!(user: user_2, word_tag: wt)

      log_in_as(user)

      visit myTags_path

      click_on tag.name

      click_on "edit tag"

      within ".header-buttons" do
        click_on "remove tag"
      end

      expect(page).to have_content("Success: \'#{tag.name}\' removed.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(2)
      expect(Tag.count).to eq(1)
      expect(UserTag.count).to eq(1)
      expect(WordTag.count).to eq(1)
      expect(UserWordTag.count).to eq(1)
    end
  end
end
