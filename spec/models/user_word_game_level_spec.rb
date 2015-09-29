require 'rails_helper'

RSpec.describe UserWordGameLevel, type: :model do
  let(:user_word_game_level) { FactoryGirl.create(:user_word_game_level) }

  describe "associatons" do
    it { should belong_to(:user_word) }
    it { should belong_to(:game_level) }
    it { should have_many(:freestyle_responses) }
  end

  describe "validations" do
    it { should validate_presence_of(:user_word) }
    it { should validate_presence_of(:game_level) }
    it { should validate_presence_of(:status) }
  end

  describe "#initialization" do
    it "returns status" do
      expect(user_word_game_level.status).to eq("not started")
    end

    it "returns UserWord and GameLevel class types" do
      expect(user_word_game_level.user_word.class).to be(UserWord)
      expect(user_word_game_level.game_level.class).to be(GameLevel)
    end
  end
end
