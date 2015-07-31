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
      expect(UserWordGameLevel.count).to eq(16)
    end
  end
end
