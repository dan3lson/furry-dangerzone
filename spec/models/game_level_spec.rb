require 'rails_helper'

RSpec.describe GameLevel, type: :model do
  describe "associatons" do
    it { should belong_to(:game) }
    it { should belong_to(:level) }
    it { should have_many(:user_word_game_levels) }
    it { should have_many(:user_words) }
  end

  describe "validations" do
    it { should validate_presence_of(:game) }
    it { should validate_presence_of(:level) }
  end

  describe "#initialization" do
    it "returns Game and Level class types" do
      game_level = FactoryGirl.create(:game_level)

      expect(game_level.game.class).to be(Game)
      expect(game_level.level.class).to be(Level)
    end
  end

  describe "#self.fundamentals" do
    it "returns an array of Fundamental game levels" do
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

      GameLevel.create!(game: game, level: level)
      GameLevel.create!(game: game, level: level_2)
      GameLevel.create!(game: game, level: level_3)
      GameLevel.create!(game: game, level: level_4)
      GameLevel.create!(game: game, level: level_5)
      GameLevel.create!(game: game, level: level_6)
      GameLevel.create!(game: game, level: level_7)
      GameLevel.create!(game: game, level: level_8)

      expect(GameLevel.fundamentals.count).to eq(8)
      expect(GameLevel.fundamentals.sample.game.name).to eq("Fundamentals")
    end
  end

  describe "#self.jeopardys" do
    it "returns an array of Jeopardy game levels" do
      game = Game.create!(
        name: "Jeopardy",
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
      level_9 = Level.create!(
        focus: "focus 9",
        direction: "direction 9"
      )
      level_10 = Level.create!(
        focus: "focus 10",
        direction: "direction 10"
      )
      level_11 = Level.create!(
        focus: "focus 11",
        direction: "direction 11"
      )
      level_12 = Level.create!(
        focus: "focus 12",
        direction: "direction 12"
      )
      level_13 = Level.create!(
        focus: "focus 13",
        direction: "direction 13"
      )
      level_14 = Level.create!(
        focus: "focus 14",
        direction: "direction 14"
      )
      level_15 = Level.create!(
        focus: "focus 15",
        direction: "direction 15"
      )
      level_16 = Level.create!(
        focus: "focus 16",
        direction: "direction 16"
      )
      level_17 = Level.create!(
        focus: "focus 17",
        direction: "direction 17"
      )
      level_18 = Level.create!(
        focus: "focus 18",
        direction: "direction 18"
      )
      level_19 = Level.create!(
        focus: "focus 19",
        direction: "direction 19"
      )
      level_20 = Level.create!(
        focus: "focus 20",
        direction: "direction 20"
      )

      GameLevel.create!(game: game, level: level)
      GameLevel.create!(game: game, level: level_2)
      GameLevel.create!(game: game, level: level_3)
      GameLevel.create!(game: game, level: level_4)
      GameLevel.create!(game: game, level: level_5)
      GameLevel.create!(game: game, level: level_6)
      GameLevel.create!(game: game, level: level_7)
      GameLevel.create!(game: game, level: level_8)
      GameLevel.create!(game: game, level: level_9)
      GameLevel.create!(game: game, level: level_10)
      GameLevel.create!(game: game, level: level_11)
      GameLevel.create!(game: game, level: level_12)
      GameLevel.create!(game: game, level: level_13)
      GameLevel.create!(game: game, level: level_14)
      GameLevel.create!(game: game, level: level_15)
      GameLevel.create!(game: game, level: level_16)
      GameLevel.create!(game: game, level: level_17)
      GameLevel.create!(game: game, level: level_18)
      GameLevel.create!(game: game, level: level_19)
      GameLevel.create!(game: game, level: level_20)

      expect(GameLevel.jeopardys.count).to eq(20)
      expect(GameLevel.jeopardys.sample.game.name).to eq("Jeopardy")
    end
  end

  describe "#self.create_fundamentals_for" do
    it "returns an array of Fundamentals UserWordGameLevel objects" do
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

      GameLevel.create!(game: game, level: level)
      GameLevel.create!(game: game, level: level_2)
      GameLevel.create!(game: game, level: level_3)
      GameLevel.create!(game: game, level: level_4)
      GameLevel.create!(game: game, level: level_5)
      GameLevel.create!(game: game, level: level_6)
      GameLevel.create!(game: game, level: level_7)
      GameLevel.create!(game: game, level: level_8)

      user_word = FactoryGirl.create(:user_word)

      GameLevel.create_fundamentals_for(user_word)

      expect(UserWordGameLevel.count).to eq(8)
    end
  end

  describe "#self.create_jeopardys_for" do
    it "returns an array of Jeopardy UserWordGameLevel objects" do
      game = Game.create!(
        name: "Jeopardy",
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
      level_9 = Level.create!(
        focus: "focus 9",
        direction: "direction 9"
      )
      level_10 = Level.create!(
        focus: "focus 10",
        direction: "direction 10"
      )
      level_11 = Level.create!(
        focus: "focus 11",
        direction: "direction 11"
      )
      level_12 = Level.create!(
        focus: "focus 12",
        direction: "direction 12"
      )
      level_13 = Level.create!(
        focus: "focus 13",
        direction: "direction 13"
      )
      level_14 = Level.create!(
        focus: "focus 14",
        direction: "direction 14"
      )
      level_15 = Level.create!(
        focus: "focus 15",
        direction: "direction 15"
      )
      level_16 = Level.create!(
        focus: "focus 16",
        direction: "direction 16"
      )
      level_17 = Level.create!(
        focus: "focus 17",
        direction: "direction 17"
      )
      level_18 = Level.create!(
        focus: "focus 18",
        direction: "direction 18"
      )
      level_19 = Level.create!(
        focus: "focus 19",
        direction: "direction 19"
      )
      level_20 = Level.create!(
        focus: "focus 20",
        direction: "direction 20"
      )

      GameLevel.create!(game: game, level: level)
      GameLevel.create!(game: game, level: level_2)
      GameLevel.create!(game: game, level: level_3)
      GameLevel.create!(game: game, level: level_4)
      GameLevel.create!(game: game, level: level_5)
      GameLevel.create!(game: game, level: level_6)
      GameLevel.create!(game: game, level: level_7)
      GameLevel.create!(game: game, level: level_8)
      GameLevel.create!(game: game, level: level_9)
      GameLevel.create!(game: game, level: level_10)
      GameLevel.create!(game: game, level: level_11)
      GameLevel.create!(game: game, level: level_12)
      GameLevel.create!(game: game, level: level_13)
      GameLevel.create!(game: game, level: level_14)
      GameLevel.create!(game: game, level: level_15)
      GameLevel.create!(game: game, level: level_16)
      GameLevel.create!(game: game, level: level_17)
      GameLevel.create!(game: game, level: level_18)
      GameLevel.create!(game: game, level: level_19)
      GameLevel.create!(game: game, level: level_20)

      user_word = FactoryGirl.create(:user_word)

      GameLevel.create_jeopardys_for(user_word)

      expect(GameLevel.jeopardys.count).to eq(20)
      expect(GameLevel.jeopardys.sample.game.name).to eq("Jeopardy")
    end
  end
end
