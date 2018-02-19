require 'rails_helper'

RSpec.describe UserWord, type: :model do
  let (:user_word) { FactoryGirl.create(:user_word) }
  let (:word) { user_word.word }
  let (:user) { user_word.user }

  describe "associatons" do
    it { should belong_to(:user) }
    it { should belong_to(:word) }
    it { should have_many(:game_stats) }
    it { should have_many(:freestyle_responses) }
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
      expect(user_word.games_completed).to eq(0)
    end

    it "returns games_completed as 0 since it\'s the default" do
      user_word = FactoryGirl.create(:user_word)

      expect(user_word.games_completed).to eq(0)
    end
  end

  skip "#template" do
    it "returns true" do
    end

    it "returns false" do
    end
  end
end
