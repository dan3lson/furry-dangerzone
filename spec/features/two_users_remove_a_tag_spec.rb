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
    let!(:word_tag) { WordTag.create(word: word, tag: tag) }

    scenario "scenario: user_1 and user_2 remove same tag w/o words" do
      game = Game.create!(
        name: "Fundamentals",
        description: "Learn the basics."
      )

      level = Level.create!(
        focus: "focus 1",
        direction: "direction 1"
      )
      level_2 = Level.create!(
        focus: "focus 2",
        direction: "direction 2"
      )
      level_3 = Level.create!(
        focus: "focus 3",
        direction: "direction 3"
      )
      level_4 = Level.create!(
        focus: "focus 4",
        direction: "direction 4"
      )
      level_5 = Level.create!(
        focus: "focus 5",
        direction: "direction 5"
      )
      level_6 = Level.create!(
        focus: "focus 6",
        direction: "direction 6"
      )
      level_7 = Level.create!(
        focus: "focus 7",
        direction: "direction 7"
      )
      level_8 = Level.create!(
        focus: "focus 8",
        direction: "direction 8"
      )

      game_level = GameLevel.create!(game: game, level: level)
      game_level_2 = GameLevel.create!(game: game, level: level_2)
      game_level_3 = GameLevel.create!(game: game, level: level_3)
      game_level_4 = GameLevel.create!(game: game, level: level_4)
      game_level_5 = GameLevel.create!(game: game, level: level_5)
      game_level_6 = GameLevel.create!(game: game, level: level_6)
      game_level_7 = GameLevel.create!(game: game, level: level_7)
      game_level_8 = GameLevel.create!(game: game, level: level_8)

      UserWordGameLevel.create!(
        user_word: user_word_1,
        game_level: game_level
      )
      UserWordGameLevel.create!(
        user_word: user_word_1,
        game_level: game_level_2
      )
      UserWordGameLevel.create!(
        user_word: user_word_1,
        game_level: game_level_3
      )
      UserWordGameLevel.create!(
        user_word: user_word_1,
        game_level: game_level_4
      )
      UserWordGameLevel.create!(
        user_word: user_word_1,
        game_level: game_level_5
      )
      UserWordGameLevel.create!(
        user_word: user_word_1,
        game_level: game_level_6
      )
      UserWordGameLevel.create!(
        user_word: user_word_1,
        game_level: game_level_7
      )
      UserWordGameLevel.create!(
        user_word: user_word_1,
        game_level: game_level_8
      )

      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_2
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_3
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_4
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_5
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_6
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_7
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_8
      )

      log_in_as(user_1)

      visit myTags_path

      click_on tag.name

      click_on "edit"

      click_on "remove"

      visit menu_path

      click_on "Log Out"

      log_in_as(user_2)

      visit myTags_path

      click_on tag.name

      click_on "edit"

      click_on "remove"

      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(2)
      expect(Tag.count).to eq(0)
      expect(UserTag.count).to eq(0)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end

    scenario "scenario: user_1 and user_2 remove same tag that has one word" do
      game = Game.create!(
        name: "Fundamentals",
        description: "Learn the basics."
      )

      level = Level.create!(
        focus: "focus 1",
        direction: "direction 1"
      )
      level_2 = Level.create!(
        focus: "focus 2",
        direction: "direction 2"
      )
      level_3 = Level.create!(
        focus: "focus 3",
        direction: "direction 3"
      )
      level_4 = Level.create!(
        focus: "focus 4",
        direction: "direction 4"
      )
      level_5 = Level.create!(
        focus: "focus 5",
        direction: "direction 5"
      )
      level_6 = Level.create!(
        focus: "focus 6",
        direction: "direction 6"
      )
      level_7 = Level.create!(
        focus: "focus 7",
        direction: "direction 7"
      )
      level_8 = Level.create!(
        focus: "focus 8",
        direction: "direction 8"
      )

      game_level = GameLevel.create!(game: game, level: level)
      game_level_2 = GameLevel.create!(game: game, level: level_2)
      game_level_3 = GameLevel.create!(game: game, level: level_3)
      game_level_4 = GameLevel.create!(game: game, level: level_4)
      game_level_5 = GameLevel.create!(game: game, level: level_5)
      game_level_6 = GameLevel.create!(game: game, level: level_6)
      game_level_7 = GameLevel.create!(game: game, level: level_7)
      game_level_8 = GameLevel.create!(game: game, level: level_8)

      UserWordGameLevel.create!(
        user_word: user_word_1,
        game_level: game_level
      )
      UserWordGameLevel.create!(
        user_word: user_word_1,
        game_level: game_level_2
      )
      UserWordGameLevel.create!(
        user_word: user_word_1,
        game_level: game_level_3
      )
      UserWordGameLevel.create!(
        user_word: user_word_1,
        game_level: game_level_4
      )
      UserWordGameLevel.create!(
        user_word: user_word_1,
        game_level: game_level_5
      )
      UserWordGameLevel.create!(
        user_word: user_word_1,
        game_level: game_level_6
      )
      UserWordGameLevel.create!(
        user_word: user_word_1,
        game_level: game_level_7
      )
      UserWordGameLevel.create!(
        user_word: user_word_1,
        game_level: game_level_8
      )

      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_2
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_3
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_4
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_5
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_6
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_7
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_8
      )

      user_word_tag_1 = UserWordTag.create(
        user: user_1, word_tag: word_tag
      )
      user_word_tag_2 = UserWordTag.create(
        user: user_2, word_tag: word_tag
      )

      log_in_as(user_1)

      visit myTags_path

      click_on tag.name

      click_on "edit"

      within ".header-buttons" do
        click_on "remove"
      end

      visit menu_path

      click_on "Log Out"

      log_in_as(user_2)

      visit myTags_path

      click_on tag.name

      click_on "edit"

      within ".header-buttons" do
        click_on "remove"
      end

      expect(Word.count).to eq(1)
      expect(UserWord.count).to eq(2)
      expect(Tag.count).to eq(0)
      expect(UserTag.count).to eq(0)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end

    scenario "scenario: user_1 and user_2 remove tag with two words" do
      word_2 = FactoryGirl.create(:word, name: "foo")
      word_tag_2 = WordTag.create(word: word_2, tag: tag)
      user_word_2 = UserWord.create(user: user_1, word: word_2)
      user_word_4 = UserWord.create(user: user_2, word: word_2)

      user_word_tag_1 = UserWordTag.create(
        user: user_1, word_tag: word_tag
      )
      user_word_tag_2 = UserWordTag.create(
        user: user_1, word_tag: word_tag_2
      )
      user_word_tag_3 = UserWordTag.create(
        user: user_2, word_tag: word_tag
      )
      user_word_tag_4 = UserWordTag.create(
        user: user_2, word_tag: word_tag_2
      )

      game = Game.create!(
        name: "Fundamentals",
        description: "Learn the basics."
      )

      level = Level.create!(
        focus: "focus 1",
        direction: "direction 1"
      )
      level_2 = Level.create!(
        focus: "focus 2",
        direction: "direction 2"
      )
      level_3 = Level.create!(
        focus: "focus 3",
        direction: "direction 3"
      )
      level_4 = Level.create!(
        focus: "focus 4",
        direction: "direction 4"
      )
      level_5 = Level.create!(
        focus: "focus 5",
        direction: "direction 5"
      )
      level_6 = Level.create!(
        focus: "focus 6",
        direction: "direction 6"
      )
      level_7 = Level.create!(
        focus: "focus 7",
        direction: "direction 7"
      )
      level_8 = Level.create!(
        focus: "focus 8",
        direction: "direction 8"
      )

      game_level = GameLevel.create!(game: game, level: level)
      game_level_2 = GameLevel.create!(game: game, level: level_2)
      game_level_3 = GameLevel.create!(game: game, level: level_3)
      game_level_4 = GameLevel.create!(game: game, level: level_4)
      game_level_5 = GameLevel.create!(game: game, level: level_5)
      game_level_6 = GameLevel.create!(game: game, level: level_6)
      game_level_7 = GameLevel.create!(game: game, level: level_7)
      game_level_8 = GameLevel.create!(game: game, level: level_8)

      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_2
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_3
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_4
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_5
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_6
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_7
      )
      UserWordGameLevel.create!(
        user_word: user_word_2,
        game_level: game_level_8
      )

      UserWordGameLevel.create!(
        user_word: user_word_4,
        game_level: game_level
      )
      UserWordGameLevel.create!(
        user_word: user_word_4,
        game_level: game_level_2
      )
      UserWordGameLevel.create!(
        user_word: user_word_4,
        game_level: game_level_3
      )
      UserWordGameLevel.create!(
        user_word: user_word_4,
        game_level: game_level_4
      )
      UserWordGameLevel.create!(
        user_word: user_word_4,
        game_level: game_level_5
      )
      UserWordGameLevel.create!(
        user_word: user_word_4,
        game_level: game_level_6
      )
      UserWordGameLevel.create!(
        user_word: user_word_4,
        game_level: game_level_7
      )
      UserWordGameLevel.create!(
        user_word: user_word_4,
        game_level: game_level_8
      )

      log_in_as(user_1)

      visit myTags_path

      click_on tag.name

      click_on "edit"

      within ".header-buttons" do
        click_on "remove"
      end

      visit menu_path

      click_on "Log Out"

      log_in_as(user_2)

      visit myTags_path

      click_on tag.name

      click_on "edit"

      within ".header-buttons" do
        click_on "remove"
      end

      expect(Word.count).to eq(2)
      expect(UserWord.count).to eq(4)
      expect(Tag.count).to eq(0)
      expect(UserTag.count).to eq(0)
      expect(WordTag.count).to eq(0)
      expect(UserWordTag.count).to eq(0)
    end
  end
end
