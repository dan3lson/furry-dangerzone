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
    it { should validate_presence_of(:games_completed) }
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

  describe "#current_game" do
    it "returns \'one\' string" do
      expect(user_word.current_game).to eq("one")
    end

    it "returns a \'two\' string" do
      user_word.games_completed = 1

      expect(user_word.current_game).to eq("two")
    end

    it "returns a \'three\' string" do
      user_word.games_completed = 2

      expect(user_word.current_game).to eq("three")
    end

    it "returns an \'all-games-completed\' string" do
      user_word.games_completed = 3

      expect(user_word.current_game).to eq("all-games-completed")
    end
  end

  describe "#fundamental_completed?" do
    it "returns true, i.e. Fundamental game is completed for UW" do
      user_word.games_completed = 1

      expect(user_word.fundamental_completed?).to eq(true)
    end

    it "returns true, i.e. Fundamental game is completed for UW" do
      user_word.games_completed = 2

      expect(user_word.fundamental_completed?).to eq(true)
    end

    it "returns true, i.e. Fundamental game is completed for UW" do
      user_word.games_completed = 3

      expect(user_word.fundamental_completed?).to eq(true)
    end

    it "returns false, i.e. Fundamental game is not completed for UW" do
      expect(user_word.fundamental_completed?).to eq(false)
    end
  end

  describe "#fundamental_not_completed?" do
    it "returns true, i.e. Fundamental game hasn\'t been started for UW" do
      expect(user_word.fundamental_not_completed?).to eq(true)
    end

    it "returns false, i.e. Fundamental game has been started for UW" do
      user_word.games_completed = 1

      expect(user_word.fundamental_not_completed?).to eq(false)
    end

    it "returns false, i.e. Fundamental game has been started for UW" do
      user_word.games_completed = 2

      expect(user_word.fundamental_not_completed?).to eq(false)
    end

    it "returns false, i.e. Fundamental game has been started for UW" do
      user_word.games_completed = 3

      expect(user_word.fundamental_not_completed?).to eq(false)
    end
  end

  describe "#jeopardy_completed?" do
    it "returns true, i.e. Jeopardy game has been completed for UW" do
      user_word.games_completed = 2

      expect(user_word.jeopardy_completed?).to eq(true)
    end

    it "returns true, i.e. Jeopardy game has been completed for UW" do
      user_word.games_completed = 3

      expect(user_word.jeopardy_completed?).to eq(true)
    end

    it "returns false, i.e. Jeopardy game has not been completed for UW" do
      user_word.games_completed = 0

      expect(user_word.jeopardy_completed?).to eq(false)
    end

    it "returns false, i.e. Jeopardy game has not been completed for UW" do
      user_word.games_completed = 1

      expect(user_word.jeopardy_completed?).to eq(false)
    end
  end

  describe "#jeopardy_not_completed?" do
    it "returns true, i.e. Jeopardy game has been started for UW" do
      user_word.games_completed = 1

      expect(user_word.jeopardy_not_completed?).to eq(true)
    end

    it "returns false, i.e. Jeopardy game has been started for UW" do
      user_word.games_completed = 2

      expect(user_word.jeopardy_not_completed?).to eq(false)
    end

    it "returns false, i.e. Jeopardy game has been started for UW" do
      user_word.games_completed = 3

      expect(user_word.jeopardy_not_completed?).to eq(false)
    end
  end

  describe "#all_freestyles_completed?" do
    it "returns true, i.e. Freestyle game has been completed for UW" do
      user_word.games_completed = 3

      expect(user_word.all_freestyles_completed?).to eq(true)
    end

    it "returns false, i.e. Freestyle game has not been completed for UW" do
      expect(user_word.all_freestyles_completed?).to eq(false)
    end

    it "returns false, i.e. Freestyle game has not been completed for UW" do
      user_word.games_completed = 1

      expect(user_word.all_freestyles_completed?).to eq(false)
    end

    it "returns false, i.e. Freestyle game has not been completed for UW" do
      user_word.games_completed = 2

      expect(user_word.all_freestyles_completed?).to eq(false)
    end
  end

  describe "#freestyle_not_completed?" do
    it "returns true" do
      user_word.games_completed = 2

      expect(user_word.freestyle_not_completed?).to eq(true)
    end

    it "returns false" do
      user_word.games_completed = 0

      expect(user_word.freestyle_not_completed?).to eq(false)
    end

    it "returns false" do
      user_word.games_completed = 1

      expect(user_word.freestyle_not_completed?).to eq(false)
    end

    it "returns false" do
      user_word.games_completed = 3

      expect(user_word.freestyle_not_completed?).to eq(false)
    end
  end

  skip "#template" do
    it "returns true" do
    end

    it "returns false" do
    end
  end
end
