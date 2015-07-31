require 'rails_helper'

RSpec.describe GameLevel, type: :model do
  let(:game_level) { FactoryGirl.create(:game_level) }

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
      expect(game_level.game.class).to be(Game)
      expect(game_level.level.class).to be(Level)
    end
  end
end
