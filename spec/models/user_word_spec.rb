require 'rails_helper'

RSpec.describe UserWord, type: :model do

  describe "associatons" do
    it { should belong_to(:user) }
    it { should belong_to(:word) }
    it { should have_many(:user_word_game_levels) }
    it { should have_many(:game_levels) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:word) }
  end

  describe "#initialization" do
    it "returns User and Word class types" do
      user_word = FactoryGirl.create(:user_word)

      expect(user_word.user.class).to be(User)
      expect(user_word.word.class).to be(Word)
    end
  end

  describe "#current_game" do
    it "returns \'one\' string" do
      word = Word.create(
        name: "foobar",
        definition: "foo plus bar equals foobar"
      )
      user = User.create(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password"
      )
      user_word = UserWord.create!(word: word, user: user)
      game = Game.create!(
        name: "Fundamentals",
        description: "Learn the basics."
      )
      level = Level.create!(
        focus: "Spelling",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Meanings",
        direction: "View diff meanings."
      )
      game_level = GameLevel.create!(game: game, level: level)
      game_level_2 = GameLevel.create!(game: game, level: level_2)
      user_word_game_level = UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level
      )
      user_word_game_level = UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_2
      )

      expect(user_word.current_game).to eq("one")
    end

    it "returns a \'two\' string" do
      word = Word.create(
        name: "foobar",
        definition: "foo plus bar equals foobar"
      )
      user = User.create(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password"
      )
      user_word = UserWord.create!(word: word, user: user)
      game = Game.create!(
        name: "Jeopardy",
        description: "Fun jeopardy twist"
      )
      level = Level.create!(
        focus: "Spelling",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Meanings",
        direction: "View diff meanings."
      )
      game_level = GameLevel.create!(game: game, level: level)
      game_level_2 = GameLevel.create!(game: game, level: level_2)
      user_word_game_level = UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level
      )
      user_word_game_level = UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_2
      )

      expect(user_word.current_game).to eq("two")
    end

    it "returns a \'three\' string" do
      word = Word.create(
        name: "foobar",
        definition: "foo plus bar equals foobar"
      )
      user = User.create(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password"
      )
      user_word = UserWord.create!(word: word, user: user)
      game = Game.create!(
        name: "Freestyle",
        description: "Be creative"
      )
      level = Level.create!(
        focus: "Spelling",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Meanings",
        direction: "View diff meanings."
      )
      game_level = GameLevel.create!(game: game, level: level)
      game_level_2 = GameLevel.create!(game: game, level: level_2)
      user_word_game_level = UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level
      )
      user_word_game_level = UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_2
      )

      expect(user_word.current_game).to eq("three")
    end

    it "returns a nil" do
      word = Word.create(
        name: "foobar",
        definition: "foo plus bar equals foobar"
      )
      user = User.create(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password"
      )
      user_word = UserWord.create!(word: word, user: user)
      game = Game.create!(
        name: "Freestyle",
        description: "Be creative"
      )
      game_2 = Game.create!(
        name: "Jeopardy",
        description: "Fun jeopardy twist"
      )
      level = Level.create!(
        focus: "Spelling",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Meanings",
        direction: "View diff meanings."
      )
      level_3 = Level.create!(
        focus: "Checkpoint",
        direction: "Select the syn or ant."
      )
      game_level = GameLevel.create!(game: game, level: level)
      game_level_2 = GameLevel.create!(game: game, level: level_2)
      game_level_3 = GameLevel.create!(game: game_2, level: level_3)
      user_word_game_level = UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level
      )
      user_word_game_level = UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_3
      )

      expect(user_word.current_game).to eq(nil)
    end
  end
end
