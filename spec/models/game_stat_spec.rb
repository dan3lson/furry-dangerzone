require 'rails_helper'

RSpec.describe GameStat, type: :model do
  let!(:game_stat) { FactoryGirl.create(:game_stat) }

  describe "associatons" do
    it { should belong_to(:user_word) }
    it { should belong_to(:game) }
  end

  describe "validations" do
    it { should validate_presence_of(:user_word) }
    it { should validate_presence_of(:game) }
  end

  describe "#initialization" do
    it "returns a game_stat user_word" do
      expect(game_stat.user_word.class).to be(UserWord)
    end
    it "returns a game_stat game" do
      expect(game_stat.game.class).to be(Game)
    end
    it "returns a num_played" do
      expect(game_stat.num_played).to be(3)
    end
    it "returns num_jeop_won" do
      expect(game_stat.num_jeop_won).to be(5)
    end
    it "returns a num_jeop_lost" do
      expect(game_stat.num_jeop_lost).to be(2)
    end
  end

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
      expect(game_stat.game.name).to eq("Say It Right")
    end

    it "returns game stats for the fourth game" do
      expect(game_stat.game.name).to eq("Decisions, Decisions")
    end

    it "returns game stats for the fifth game" do
      expect(game_stat.game.name).to eq("Examples/Non-Examples")
    end

    it "returns game stats for the sixth game" do
      expect(game_stat.game.name).to eq("Syns vs Ants")
    end
  end
end
