require 'rails_helper'

RSpec.describe UserWord, type: :model do

  describe "associatons" do
    it { should belong_to(:user) }
    it { should belong_to(:word) }
    it { should have_many(:user_word_game_levels) }
    it { should have_many(:game_levels) }
    it { should have_many(:game_stats) }
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
        focus: "Spelling",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Meanings",
        direction: "Direction"
      )

      game_level = GameLevel.create!(game: game, level: level)
      game_level_2 = GameLevel.create!(game: game, level: level_2)

      UserWordGameLevel.create!(user_word: user_word, game_level: game_level)

      UserWordGameLevel.create!(user_word: user_word, game_level: game_level_2)

      expect(user_word.current_game).to eq("one")
    end

    it "returns a \'two\' string" do
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

      game_fundamental = Game.create!(
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
        direction: "Direction"
      )

      fund_gl = GameLevel.create!(game: game_fundamental, level: level)
      game_level = GameLevel.create!(game: game_jeopardy, level: level)
      game_level_2 = GameLevel.create!(game: game_jeopardy, level: level_2)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl)
      UserWordGameLevel.create!(user_word: user_word, game_level: game_level)
      UserWordGameLevel.create!(user_word: user_word, game_level: game_level_2)

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

      game_fundamental = Game.create!(
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
        direction: "Direction"
      )

      fund_gl = GameLevel.create!(game: game_fundamental, level: level)
      jeop_gl = GameLevel.create!(game: game_jeopardy, level: level)
      game_level = GameLevel.create!(game: game_freestyle, level: level)
      game_level_2 = GameLevel.create!(game: game_freestyle, level: level_2)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl)
      UserWordGameLevel.create!(user_word: user_word, game_level: game_level_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: game_level_2)

      expect(user_word.current_game).to eq("three")
    end

    it "returns an \'all-games-completed\' string" do
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )
      level_29 = Level.create!(
        focus: "Freestyle focus 29",
        direction: "Direction"
      )
      level_30 = Level.create!(
        focus: "Freestyle focus 30",
        direction: "Direction"
      )
      level_31 = Level.create!(
        focus: "Freestyle focus 31",
        direction: "Direction"
      )
      level_32 = Level.create!(
        focus: "Freestyle focus 32",
        direction: "Direction"
      )
      level_33 = Level.create!(
        focus: "Freestyle focus 33",
        direction: "Direction"
      )
      level_34 = Level.create!(
        focus: "Freestyle focus 34",
        direction: "Type the word below:"
      )
      level_35 = Level.create!(
        focus: "Freestyle focus 35",
        direction: "Direction"
      )
      level_36 = Level.create!(
        focus: "Freestyle focus 36",
        direction: "Direction"
      )
      level_37 = Level.create!(
        focus: "Freestyle focus 37",
        direction: "Direction"
      )
      level_38 = Level.create!(
        focus: "Freestyle focus 38",
        direction: "Direction"
      )
      level_39 = Level.create!(
        focus: "Freestyle focus 39",
        direction: "Direction"
      )
      level_40 = Level.create!(
        focus: "Freestyle focus 40",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)
      free_gl_29 = GameLevel.create!(game: game_freestyle, level: level_29)
      free_gl_30 = GameLevel.create!(game: game_freestyle, level: level_30)
      free_gl_31 = GameLevel.create!(game: game_freestyle, level: level_31)
      free_gl_32 = GameLevel.create!(game: game_freestyle, level: level_32)
      free_gl_33 = GameLevel.create!(game: game_freestyle, level: level_33)
      free_gl_34 = GameLevel.create!(game: game_freestyle, level: level_34)
      free_gl_35 = GameLevel.create!(game: game_freestyle, level: level_35)
      free_gl_36 = GameLevel.create!(game: game_freestyle, level: level_36)
      free_gl_37 = GameLevel.create!(game: game_freestyle, level: level_37)
      free_gl_38 = GameLevel.create!(game: game_freestyle, level: level_38)
      free_gl_39 = GameLevel.create!(game: game_freestyle, level: level_39)
      free_gl_40 = GameLevel.create!(game: game_freestyle, level: level_40)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_40)

      UserWordGameLevel.all.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      expect(user_word.current_game).to eq("all-games-completed")
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )
      level_29 = Level.create!(
        focus: "Freestyle focus 29",
        direction: "Direction"
      )
      level_30 = Level.create!(
        focus: "Freestyle focus 30",
        direction: "Direction"
      )
      level_31 = Level.create!(
        focus: "Freestyle focus 31",
        direction: "Direction"
      )
      level_32 = Level.create!(
        focus: "Freestyle focus 32",
        direction: "Direction"
      )
      level_33 = Level.create!(
        focus: "Freestyle focus 33",
        direction: "Direction"
      )
      level_34 = Level.create!(
        focus: "Freestyle focus 34",
        direction: "Type the word below:"
      )
      level_35 = Level.create!(
        focus: "Freestyle focus 35",
        direction: "Direction"
      )
      level_36 = Level.create!(
        focus: "Freestyle focus 36",
        direction: "Direction"
      )
      level_37 = Level.create!(
        focus: "Freestyle focus 37",
        direction: "Direction"
      )
      level_38 = Level.create!(
        focus: "Freestyle focus 38",
        direction: "Direction"
      )
      level_39 = Level.create!(
        focus: "Freestyle focus 39",
        direction: "Direction"
      )
      level_40 = Level.create!(
        focus: "Freestyle focus 40",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)
      free_gl_29 = GameLevel.create!(game: game_freestyle, level: level_29)
      free_gl_30 = GameLevel.create!(game: game_freestyle, level: level_30)
      free_gl_31 = GameLevel.create!(game: game_freestyle, level: level_31)
      free_gl_32 = GameLevel.create!(game: game_freestyle, level: level_32)
      free_gl_33 = GameLevel.create!(game: game_freestyle, level: level_33)
      free_gl_34 = GameLevel.create!(game: game_freestyle, level: level_34)
      free_gl_35 = GameLevel.create!(game: game_freestyle, level: level_35)
      free_gl_36 = GameLevel.create!(game: game_freestyle, level: level_36)
      free_gl_37 = GameLevel.create!(game: game_freestyle, level: level_37)
      free_gl_38 = GameLevel.create!(game: game_freestyle, level: level_38)
      free_gl_39 = GameLevel.create!(game: game_freestyle, level: level_39)
      free_gl_40 = GameLevel.create!(game: game_freestyle, level: level_40)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_40)

      expect(user_word.uwgl_fundamentals.count).to eq(8)
      expect(user_word.uwgl_fundamentals.any? { |uwgl|
        uwgl.game_level.game.name != "Fundamentals"
      }).to eq(false)
    end
  end

  describe "#uwgl_jeopardys" do
    it "returns user_word_game_level's that are Jeopardys" do
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )
      level_29 = Level.create!(
        focus: "Freestyle focus 29",
        direction: "Direction"
      )
      level_30 = Level.create!(
        focus: "Freestyle focus 30",
        direction: "Direction"
      )
      level_31 = Level.create!(
        focus: "Freestyle focus 31",
        direction: "Direction"
      )
      level_32 = Level.create!(
        focus: "Freestyle focus 32",
        direction: "Direction"
      )
      level_33 = Level.create!(
        focus: "Freestyle focus 33",
        direction: "Direction"
      )
      level_34 = Level.create!(
        focus: "Freestyle focus 34",
        direction: "Type the word below:"
      )
      level_35 = Level.create!(
        focus: "Freestyle focus 35",
        direction: "Direction"
      )
      level_36 = Level.create!(
        focus: "Freestyle focus 36",
        direction: "Direction"
      )
      level_37 = Level.create!(
        focus: "Freestyle focus 37",
        direction: "Direction"
      )
      level_38 = Level.create!(
        focus: "Freestyle focus 38",
        direction: "Direction"
      )
      level_39 = Level.create!(
        focus: "Freestyle focus 39",
        direction: "Direction"
      )
      level_40 = Level.create!(
        focus: "Freestyle focus 40",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)
      free_gl_29 = GameLevel.create!(game: game_freestyle, level: level_29)
      free_gl_30 = GameLevel.create!(game: game_freestyle, level: level_30)
      free_gl_31 = GameLevel.create!(game: game_freestyle, level: level_31)
      free_gl_32 = GameLevel.create!(game: game_freestyle, level: level_32)
      free_gl_33 = GameLevel.create!(game: game_freestyle, level: level_33)
      free_gl_34 = GameLevel.create!(game: game_freestyle, level: level_34)
      free_gl_35 = GameLevel.create!(game: game_freestyle, level: level_35)
      free_gl_36 = GameLevel.create!(game: game_freestyle, level: level_36)
      free_gl_37 = GameLevel.create!(game: game_freestyle, level: level_37)
      free_gl_38 = GameLevel.create!(game: game_freestyle, level: level_38)
      free_gl_39 = GameLevel.create!(game: game_freestyle, level: level_39)
      free_gl_40 = GameLevel.create!(game: game_freestyle, level: level_40)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_40)

      expect(user_word.uwgl_jeopardys.count).to eq(20)
      expect(user_word.uwgl_jeopardys.any? { |uwgl|
        uwgl.game_level.game.name != "Jeopardy"
      }).to eq(false)
    end
  end

  describe "#uwgl_freestyles" do
    it "returns user_word_game_level's that are Freestyles" do
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )
      level_29 = Level.create!(
        focus: "Freestyle focus 29",
        direction: "Direction"
      )
      level_30 = Level.create!(
        focus: "Freestyle focus 30",
        direction: "Direction"
      )
      level_31 = Level.create!(
        focus: "Freestyle focus 31",
        direction: "Direction"
      )
      level_32 = Level.create!(
        focus: "Freestyle focus 32",
        direction: "Direction"
      )
      level_33 = Level.create!(
        focus: "Freestyle focus 33",
        direction: "Direction"
      )
      level_34 = Level.create!(
        focus: "Freestyle focus 34",
        direction: "Type the word below:"
      )
      level_35 = Level.create!(
        focus: "Freestyle focus 35",
        direction: "Direction"
      )
      level_36 = Level.create!(
        focus: "Freestyle focus 36",
        direction: "Direction"
      )
      level_37 = Level.create!(
        focus: "Freestyle focus 37",
        direction: "Direction"
      )
      level_38 = Level.create!(
        focus: "Freestyle focus 38",
        direction: "Direction"
      )
      level_39 = Level.create!(
        focus: "Freestyle focus 39",
        direction: "Direction"
      )
      level_40 = Level.create!(
        focus: "Freestyle focus 40",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)
      free_gl_29 = GameLevel.create!(game: game_freestyle, level: level_29)
      free_gl_30 = GameLevel.create!(game: game_freestyle, level: level_30)
      free_gl_31 = GameLevel.create!(game: game_freestyle, level: level_31)
      free_gl_32 = GameLevel.create!(game: game_freestyle, level: level_32)
      free_gl_33 = GameLevel.create!(game: game_freestyle, level: level_33)
      free_gl_34 = GameLevel.create!(game: game_freestyle, level: level_34)
      free_gl_35 = GameLevel.create!(game: game_freestyle, level: level_35)
      free_gl_36 = GameLevel.create!(game: game_freestyle, level: level_36)
      free_gl_37 = GameLevel.create!(game: game_freestyle, level: level_37)
      free_gl_38 = GameLevel.create!(game: game_freestyle, level: level_38)
      free_gl_39 = GameLevel.create!(game: game_freestyle, level: level_39)
      free_gl_40 = GameLevel.create!(game: game_freestyle, level: level_40)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_40)

      expect(user_word.uwgl_freestyles.count).to eq(12)
      expect(user_word.uwgl_freestyles.any? { |uwgl|
        uwgl.game_level.game.name != "Freestyle"
      }).to eq(false)
    end
  end

  describe "#fundamental_not_started?" do
    it "returns true, i.e. Fundamental game hasn\'t been started for UW" do
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)

      expect(user_word.fundamental_not_started?).to eq(true)
    end

    it "returns false, i.e. Fundamental game has been started for UW" do
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)

      uwgl = UserWordGameLevel.first
      uwgl.status = "complete"
      uwgl.save

      expect(user_word.fundamental_not_started?).to eq(false)
    end
  end

  describe "#fundamental_completed?" do
    it "returns true, i.e. Fundamental game is completed for UW" do
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)

      UserWordGameLevel.all.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      expect(user_word.fundamental_completed?).to eq(true)
    end

    it "returns false, i.e. Fundamental game is not completed for UW -> in p" do
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)

      uwgl = UserWordGameLevel.first
      uwgl.status = "complete"
      uwgl.save

      expect(user_word.fundamental_completed?).to eq(false)
    end

    it "returns false, i.e. Fundamental game is not completed for UW -> ns" do
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)

      expect(user_word.fundamental_completed?).to eq(false)
    end
  end

  describe "#jeopardy_not_started?" do
    it "returns true, i.e. Jeopardy game hasn\'t been started for UW" do
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      expect(user_word.jeopardy_not_started?).to eq(true)
    end

    it "returns false, i.e. Jeopardy game has been started for UW" do
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      rand_j = user_word.uwgl_jeopardys.sample
      rand_j.status = "complete"
      rand_j.save

      expect(user_word.jeopardy_not_started?).to eq(false)
    end
  end

  describe "#jeopardy_completed?" do
    it "returns true, i.e. Jeopardy game hasn been completed for UW" do
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      expect(user_word.jeopardy_completed?).to eq(true)
    end

    it "returns false, i.e. Jeopardy game has not been completed for UW" do
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      expect(user_word.jeopardy_completed?).to eq(false)
    end
  end

  describe "#freestyle_not_started?" do
    it "returns true, i.e. Freestyle game hasn\'t been started for UW" do
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )
      level_29 = Level.create!(
        focus: "Freestyle focus 29",
        direction: "Direction"
      )
      level_30 = Level.create!(
        focus: "Freestyle focus 30",
        direction: "Direction"
      )
      level_31 = Level.create!(
        focus: "Freestyle focus 31",
        direction: "Direction"
      )
      level_32 = Level.create!(
        focus: "Freestyle focus 32",
        direction: "Direction"
      )
      level_33 = Level.create!(
        focus: "Freestyle focus 33",
        direction: "Direction"
      )
      level_34 = Level.create!(
        focus: "Freestyle focus 34",
        direction: "Type the word below:"
      )
      level_35 = Level.create!(
        focus: "Freestyle focus 35",
        direction: "Direction"
      )
      level_36 = Level.create!(
        focus: "Freestyle focus 36",
        direction: "Direction"
      )
      level_37 = Level.create!(
        focus: "Freestyle focus 37",
        direction: "Direction"
      )
      level_38 = Level.create!(
        focus: "Freestyle focus 38",
        direction: "Direction"
      )
      level_39 = Level.create!(
        focus: "Freestyle focus 39",
        direction: "Direction"
      )
      level_40 = Level.create!(
        focus: "Freestyle focus 40",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)
      free_gl_29 = GameLevel.create!(game: game_freestyle, level: level_29)
      free_gl_30 = GameLevel.create!(game: game_freestyle, level: level_30)
      free_gl_31 = GameLevel.create!(game: game_freestyle, level: level_31)
      free_gl_32 = GameLevel.create!(game: game_freestyle, level: level_32)
      free_gl_33 = GameLevel.create!(game: game_freestyle, level: level_33)
      free_gl_34 = GameLevel.create!(game: game_freestyle, level: level_34)
      free_gl_35 = GameLevel.create!(game: game_freestyle, level: level_35)
      free_gl_36 = GameLevel.create!(game: game_freestyle, level: level_36)
      free_gl_37 = GameLevel.create!(game: game_freestyle, level: level_37)
      free_gl_38 = GameLevel.create!(game: game_freestyle, level: level_38)
      free_gl_39 = GameLevel.create!(game: game_freestyle, level: level_39)
      free_gl_40 = GameLevel.create!(game: game_freestyle, level: level_40)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_40)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      expect(user_word.freestyle_not_started?).to eq(true)
    end

    it "returns false, i.e. Freestyle game has started for UW" do
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )
      level_29 = Level.create!(
        focus: "Freestyle focus 29",
        direction: "Direction"
      )
      level_30 = Level.create!(
        focus: "Freestyle focus 30",
        direction: "Direction"
      )
      level_31 = Level.create!(
        focus: "Freestyle focus 31",
        direction: "Direction"
      )
      level_32 = Level.create!(
        focus: "Freestyle focus 32",
        direction: "Direction"
      )
      level_33 = Level.create!(
        focus: "Freestyle focus 33",
        direction: "Direction"
      )
      level_34 = Level.create!(
        focus: "Freestyle focus 34",
        direction: "Type the word below:"
      )
      level_35 = Level.create!(
        focus: "Freestyle focus 35",
        direction: "Direction"
      )
      level_36 = Level.create!(
        focus: "Freestyle focus 36",
        direction: "Direction"
      )
      level_37 = Level.create!(
        focus: "Freestyle focus 37",
        direction: "Direction"
      )
      level_38 = Level.create!(
        focus: "Freestyle focus 38",
        direction: "Direction"
      )
      level_39 = Level.create!(
        focus: "Freestyle focus 39",
        direction: "Direction"
      )
      level_40 = Level.create!(
        focus: "Freestyle focus 40",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)
      free_gl_29 = GameLevel.create!(game: game_freestyle, level: level_29)
      free_gl_30 = GameLevel.create!(game: game_freestyle, level: level_30)
      free_gl_31 = GameLevel.create!(game: game_freestyle, level: level_31)
      free_gl_32 = GameLevel.create!(game: game_freestyle, level: level_32)
      free_gl_33 = GameLevel.create!(game: game_freestyle, level: level_33)
      free_gl_34 = GameLevel.create!(game: game_freestyle, level: level_34)
      free_gl_35 = GameLevel.create!(game: game_freestyle, level: level_35)
      free_gl_36 = GameLevel.create!(game: game_freestyle, level: level_36)
      free_gl_37 = GameLevel.create!(game: game_freestyle, level: level_37)
      free_gl_38 = GameLevel.create!(game: game_freestyle, level: level_38)
      free_gl_39 = GameLevel.create!(game: game_freestyle, level: level_39)
      free_gl_40 = GameLevel.create!(game: game_freestyle, level: level_40)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_40)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      free_uwgl = user_word.uwgl_freestyles.sample
      free_uwgl.status = "complete"
      free_uwgl.save

      expect(user_word.freestyle_not_started?).to eq(false)
    end
  end

  describe "#freestyle_completed?" do
    it "returns true, i.e. Freestyle game has been completed for UW" do
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )
      level_29 = Level.create!(
        focus: "Freestyle focus 29",
        direction: "Direction"
      )
      level_30 = Level.create!(
        focus: "Freestyle focus 30",
        direction: "Direction"
      )
      level_31 = Level.create!(
        focus: "Freestyle focus 31",
        direction: "Direction"
      )
      level_32 = Level.create!(
        focus: "Freestyle focus 32",
        direction: "Direction"
      )
      level_33 = Level.create!(
        focus: "Freestyle focus 33",
        direction: "Direction"
      )
      level_34 = Level.create!(
        focus: "Freestyle focus 34",
        direction: "Type the word below:"
      )
      level_35 = Level.create!(
        focus: "Freestyle focus 35",
        direction: "Direction"
      )
      level_36 = Level.create!(
        focus: "Freestyle focus 36",
        direction: "Direction"
      )
      level_37 = Level.create!(
        focus: "Freestyle focus 37",
        direction: "Direction"
      )
      level_38 = Level.create!(
        focus: "Freestyle focus 38",
        direction: "Direction"
      )
      level_39 = Level.create!(
        focus: "Freestyle focus 39",
        direction: "Direction"
      )
      level_40 = Level.create!(
        focus: "Freestyle focus 40",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)
      free_gl_29 = GameLevel.create!(game: game_freestyle, level: level_29)
      free_gl_30 = GameLevel.create!(game: game_freestyle, level: level_30)
      free_gl_31 = GameLevel.create!(game: game_freestyle, level: level_31)
      free_gl_32 = GameLevel.create!(game: game_freestyle, level: level_32)
      free_gl_33 = GameLevel.create!(game: game_freestyle, level: level_33)
      free_gl_34 = GameLevel.create!(game: game_freestyle, level: level_34)
      free_gl_35 = GameLevel.create!(game: game_freestyle, level: level_35)
      free_gl_36 = GameLevel.create!(game: game_freestyle, level: level_36)
      free_gl_37 = GameLevel.create!(game: game_freestyle, level: level_37)
      free_gl_38 = GameLevel.create!(game: game_freestyle, level: level_38)
      free_gl_39 = GameLevel.create!(game: game_freestyle, level: level_39)
      free_gl_40 = GameLevel.create!(game: game_freestyle, level: level_40)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_40)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word.uwgl_freestyles.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      expect(user_word.freestyle_completed?).to eq(true)
    end

    it "returns false, i.e. Freestyle game has not been completed for UW" do
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

      game_fundamental = Game.create!(
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

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )
      level_29 = Level.create!(
        focus: "Freestyle focus 29",
        direction: "Direction"
      )
      level_30 = Level.create!(
        focus: "Freestyle focus 30",
        direction: "Direction"
      )
      level_31 = Level.create!(
        focus: "Freestyle focus 31",
        direction: "Direction"
      )
      level_32 = Level.create!(
        focus: "Freestyle focus 32",
        direction: "Direction"
      )
      level_33 = Level.create!(
        focus: "Freestyle focus 33",
        direction: "Direction"
      )
      level_34 = Level.create!(
        focus: "Freestyle focus 34",
        direction: "Type the word below:"
      )
      level_35 = Level.create!(
        focus: "Freestyle focus 35",
        direction: "Direction"
      )
      level_36 = Level.create!(
        focus: "Freestyle focus 36",
        direction: "Direction"
      )
      level_37 = Level.create!(
        focus: "Freestyle focus 37",
        direction: "Direction"
      )
      level_38 = Level.create!(
        focus: "Freestyle focus 38",
        direction: "Direction"
      )
      level_39 = Level.create!(
        focus: "Freestyle focus 39",
        direction: "Direction"
      )
      level_40 = Level.create!(
        focus: "Freestyle focus 40",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)
      free_gl_29 = GameLevel.create!(game: game_freestyle, level: level_29)
      free_gl_30 = GameLevel.create!(game: game_freestyle, level: level_30)
      free_gl_31 = GameLevel.create!(game: game_freestyle, level: level_31)
      free_gl_32 = GameLevel.create!(game: game_freestyle, level: level_32)
      free_gl_33 = GameLevel.create!(game: game_freestyle, level: level_33)
      free_gl_34 = GameLevel.create!(game: game_freestyle, level: level_34)
      free_gl_35 = GameLevel.create!(game: game_freestyle, level: level_35)
      free_gl_36 = GameLevel.create!(game: game_freestyle, level: level_36)
      free_gl_37 = GameLevel.create!(game: game_freestyle, level: level_37)
      free_gl_38 = GameLevel.create!(game: game_freestyle, level: level_38)
      free_gl_39 = GameLevel.create!(game: game_freestyle, level: level_39)
      free_gl_40 = GameLevel.create!(game: game_freestyle, level: level_40)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_40)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      expect(user_word.freestyle_completed?).to eq(false)
    end
  end

  describe "#self.destroy_jeopardys_for" do
    it "returns 0 UWGL Jeopardy objects" do
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

      game_fundamental = Game.create!(
        name: "Fundamentals",
        description: "Be creative"
      )
      game_jeopardy = Game.create!(
        name: "Jeopardy",
        description: "Be creative"
      )

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      UserWord.destroy_jeopardys_for(user_word)

      expect(user_word.user_word_game_levels.count).to eq(8)
      expect(UserWordGameLevel.count).to eq(8)
      # expect(user_word.uwgl_jeopardys.count).to eq(0)
    end
  end
end
