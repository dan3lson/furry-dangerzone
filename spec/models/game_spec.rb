require 'rails_helper'

RSpec.describe Game, type: :model do
  let!(:game) { FactoryGirl.create(:game) }

  describe "associatons" do
    it { should have_many(:game_stats) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end

  describe "#initialization" do
    it "returns a game name" do
      expect(game.name).to eq("Fundamentals")
    end
    it "returns a game description" do
      expect(game.description).to eq("Begin to understand a word ...")
    end
  end
end
