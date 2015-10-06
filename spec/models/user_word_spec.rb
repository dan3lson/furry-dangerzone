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
        password_confirmation: "password",
        email: ""
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
        password_confirmation: "password",
        email: ""
      )
      user_word = UserWord.create!(word: word, user: user)
      game_fundamentals = Game.create!(
        name: "Fundamentals",
        description: "Fun jeopardy twist"
      )
      game_jeopardy = Game.create!(
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
      game_level_0 = GameLevel.create!(game: game_fundamentals, level: level)
      game_level = GameLevel.create!(game: game_jeopardy, level: level)
      game_level_2 = GameLevel.create!(game: game_jeopardy, level: level_2)
      user_word_game_level = UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_0
      )
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
        password_confirmation: "password",
        email: ""
      )
      user_word = UserWord.create!(word: word, user: user)
      game_fundamentals = Game.create!(
        name: "Fundamentals",
        description: "Be creative"
      )
      game_jeopardy = Game.create!(
        name: "Jeopardy",
        description: "Be creative"
      )
      game_freestyle = Game.create!(
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
      game_level_0 = GameLevel.create!(game: game_fundamentals, level: level)
      game_level_0_0 = GameLevel.create!(game: game_jeopardy, level: level)
      game_level = GameLevel.create!(game: game_freestyle, level: level)
      game_level_2 = GameLevel.create!(game: game_freestyle, level: level_2)
      user_word_game_level = UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_0
      )
      user_word_game_level = UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_0_0
      )
      user_word_game_level = UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_2
      )
      user_word_game_level = UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_2
      )

      expect(user_word.current_game).to eq("three")
    end
  end

  describe "#uwgl_fundamentals" do
    it "returns user_word_game_level's that are Fundamentals" do
      user = User.create(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password",
        email: ""
      )

      word = Word.create(
        name: "foobar",
        definition: "foo plus bar equals foobar"
      )

      user_word = UserWord.create!(word: word, user: user)

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
        user_word: user_word,
        game_level: game_level
      )
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_2
      )
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_3
      )
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_4
      )
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_5
      )
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_6
      )
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_7
      )
      UserWordGameLevel.create!(
        user_word: user_word,
        game_level: game_level_8
      )

      expect(user_word.uwgl_fundamentals.count).to eq(8)
      expect(user_word.uwgl_fundamentals.any? { |uwgl|
        uwgl.game_level.game.name != "Fundamentals"
      }).to eq(false)
    end
  end
end
