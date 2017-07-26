require 'rails_helper'

RSpec.describe GameStat, type: :model do
  let!(:game_stat) { FactoryGirl.create(:game_stat) }

  describe "::funds" do
    it "returns game stats for the first game" do
      expect(game_stat.game.name).to eq("Speed Speller")
    end

    it "returns game stats for the second game" do
      game = FactoryGirl.create(:game, name: "Jumbled Letters")
      game_stat = FactoryGirl.create(:game_stat, game: game )

      expect(game_stat.game.name).to eq("Jumbled Letters")
    end

    it "returns game stats for the third game" do
      game = FactoryGirl.create(:game, name: "Say It Right")
      game_stat = FactoryGirl.create(:game_stat, game: game )

      expect(game_stat.game.name).to eq("Say It Right")
    end

    it "returns game stats for the fourth game" do
      game = FactoryGirl.create(:game, name: "Decisions, Decisions")
      game_stat = FactoryGirl.create(:game_stat, game: game )

      expect(game_stat.game.name).to eq("Decisions, Decisions")
    end

    it "returns game stats for the fifth game" do
      game = FactoryGirl.create(:game, name: "Examples/Non-Examples")
      game_stat = FactoryGirl.create(:game_stat, game: game )

      expect(game_stat.game.name).to eq("Examples/Non-Examples")
    end

    it "returns game stats for the sixth game" do
      game = FactoryGirl.create(:game, name: "Syns vs Ants")
      game_stat = FactoryGirl.create(:game_stat, game: game )

      expect(game_stat.game.name).to eq("Syns vs Ants")
    end
  end

  describe "::jeops" do
    it "returns the game stats for level seven game" do
      game = FactoryGirl.create(:game, name:"Jeopardy")
      game_stat = FactoryGirl.create(:game_stat, game: game)

      expect(game_stat.game.name).to eq("Jeopardy")
    end

    it "returns game stats for level eight game" do
      game = FactoryGirl.create(:game, name: "Match 'Em All")
      game_stat = FactoryGirl.create(:game_stat, game: game )

      expect(game_stat.game.name).to eq("Match 'Em All")
    end
  end

  describe "::frees" do
    it "returns game stats for level nine game" do
      game = FactoryGirl.create(:game, name: "Sentence Stems")
      game_stat = FactoryGirl.create(:game_stat, game: game)

      expect(game_stat.game.name).to eq("Sentence Stems")
    end

    it "returns game stats for level ten game" do
      game = FactoryGirl.create(:game, name: "Word Relationships")
      game_stat = FactoryGirl.create(:game_stat, game: game)

      expect(game_stat.game.name).to eq("Word Relationships")
    end

    it "returns game stats for level 11 game" do
      game = FactoryGirl.create(:game, name: "Leksi Tale")
      game_stat = FactoryGirl.create(:game_stat, game: game)

      expect(game_stat.game.name).to eq("Leksi Tale")
    end

    it "returns game stats for level 12 game" do
      game = FactoryGirl.create(:game, name: "Describe Me, Describe Me Not")
      game_stat = FactoryGirl.create(:game_stat, game: game)

      expect(game_stat.game.name).to eq("Describe Me, Describe Me Not")
    end
  end

  describe "::last_24_hours" do
    it "returns one game_stat object" do
      expect(GameStat.last_24_hours.count).to eq(1)
    end

    it "returns three game_stat object" do
      FactoryGirl.create(:game_stat)
      FactoryGirl.create(:game_stat)

      expect(GameStat.last_24_hours.count).to eq(3)
    end

    it "returns zero game_stat objects" do
      GameStat.destroy_all

      expect(GameStat.last_24_hours.count).to eq(0)
    end
  end
end
