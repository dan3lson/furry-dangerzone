require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user_word) { FactoryGirl.create(:user_word) }
  let(:user) { user_word.user }
  let(:word) { user_word.word }
  let(:word_2) { Word.create!(name: "foobar_2", definition: "foobar_2_def") }
  let(:word_3) { Word.create!(name: "foobar_3", definition: "foobar_3_def") }
  let(:word_4) { Word.create!(name: "foobar_4", definition: "foobar_4_def") }

  describe "#weekly_goal" do
    it "returns \'Basic\'" do
      user.goal = 1

      expect(weekly_goal(user)).to eq("Basic")
    end

    it "returns \'Casual\'" do
      user.goal = 5

      expect(weekly_goal(user)).to eq("Casual")
    end

    it "returns \'Regular\'" do
      user.goal = 10

      expect(weekly_goal(user)).to eq("Regular")
    end

    it "returns \'Serious\'" do
      user.goal = 20

      expect(weekly_goal(user)).to eq("Serious")
    end

    it "returns \'Insane\'" do
      user.goal = 30

      expect(weekly_goal(user)).to eq("Insane")
    end

    it "returns \'No goal set\'" do
      expect(weekly_goal(user)).to eq("No goal set")
    end
  end

  describe "#words_mastered_in_a_week" do
    it "returns 1 and \'chess\'" do
      user_word.games_completed = 3
      user_word.save

      expect(words_mastered_in_a_week(user).count).to eq(1)
      expect(words_mastered_in_a_week(user).first.word.name).to eq("chess")
    end

    it "returns 2 and \'foobar_2' and \'foobar_3\'" do
      user_word_2 = UserWord.create!(user: user, word: word_2)
      user_word_2.games_completed = 3
      user_word_2.save

      user_word_3 = UserWord.create!(user: user, word: word_3)
      user_word_3.games_completed = 3
      user_word_3.save

      words = words_mastered_in_a_week(user)
      word_names = words.map { |uw| uw.word.name }

      expect(words.count).to eq(2)
      expect(word_names.include?("foobar_2")).to eq(true)
      expect(word_names.include?("foobar_3")).to eq(true)
      expect(word_names.include?("chess")).to eq(false)
    end

    it "returns 0" do
      user_word.updated_at = 2.weeks.ago
      user_word.save

      user_word_2 = UserWord.create!(user: user, word: word_2)
      user_word_2.games_completed = 3
      user_word_2.updated_at = 1.month.ago
      user_word_2.save

      user_word_3 = UserWord.create!(user: user, word: word_3)
      user_word_3.games_completed = 3
      user_word_3.updated_at = 1.year.ago
      user_word_3.save

      expect(words_mastered_in_a_week(user).count).to eq(0)
    end

    it "returns 1 and \'chess\'" do
      user_word.games_completed = 3
      user_word.save

      user_word_2 = UserWord.create!(user: user, word: word_2)
      user_word_2.games_completed = 3
      user_word_2.updated_at = 1.month.ago
      user_word_2.save

      user_word_3 = UserWord.create!(user: user, word: word_3)
      user_word_3.games_completed = 3
      user_word_3.updated_at = 1.year.ago
      user_word_3.save

      words = words_mastered_in_a_week(user)
      word_names = words.map { |uw| uw.word.name }

      expect(words.count).to eq(1)
      expect(word_names.include?("chess")).to eq(true)
      expect(word_names.include?("foobar_2")).to eq(false)
      expect(word_names.include?("foobar_3")).to eq(false)
    end
  end

  describe "#num_words_mastered_in_a_week" do
    it "returns 1" do
      user_word.games_completed = 3
      user_word.save

      expect(num_words_mastered_in_a_week(user)).to eq(1)
    end

    it "returns 2" do
      user_word_2 = UserWord.create!(user: user, word: word_2)
      user_word_2.games_completed = 3
      user_word_2.save

      user_word_3 = UserWord.create!(user: user, word: word_3)
      user_word_3.games_completed = 3
      user_word_3.save

      expect(num_words_mastered_in_a_week(user)).to eq(2)
    end

    it "returns 0" do
      user_word.updated_at = 2.weeks.ago
      user_word.save

      user_word_2 = UserWord.create!(user: user, word: word_2)
      user_word_2.games_completed = 3
      user_word_2.updated_at = 1.month.ago
      user_word_2.save

      user_word_3 = UserWord.create!(user: user, word: word_3)
      user_word_3.games_completed = 3
      user_word_3.updated_at = 1.year.ago
      user_word_3.save

      expect(num_words_mastered_in_a_week(user)).to eq(0)
    end

    it "returns 1 (mixed)" do
      user_word.games_completed = 3
      user_word.save

      user_word_2 = UserWord.create!(user: user, word: word_2)
      user_word_2.games_completed = 3
      user_word_2.updated_at = 1.month.ago
      user_word_2.save

      user_word_3 = UserWord.create!(user: user, word: word_3)
      user_word_3.games_completed = 3
      user_word_3.updated_at = 1.year.ago
      user_word_3.save

      expect(num_words_mastered_in_a_week(user)).to eq(1)
    end
  end

  describe "#weekly_goal_completed?" do
    it "returns true" do
      user_word.games_completed = 3
      user_word.save

      user.goal = 1

      expect(weekly_goal_completed?(user)).to eq(true)
    end

    it "returns true" do
      user_word_2 = UserWord.create!(user: user, word: word_2)

      user_word.games_completed = 3
      user_word.save

      user_word_2.games_completed = 3
      user_word_2.save

      user.goal = 1

      expect(weekly_goal_completed?(user)).to eq(true)
    end

    it "returns false" do
      user_word_2 = UserWord.create!(user: user, word: word_2)

      user_word.games_completed = 3
      user_word.save

      user_word_2.games_completed = 3
      user_word_2.save

      user.goal = 10

      expect(weekly_goal_completed?(user)).to eq(false)
    end
  end

  describe "#goal_percentage_completion" do
    it "returns 0" do
      expect(goal_percentage_completion(user)).to eq(0)
    end

    it "returns 30" do
      user_word.games_completed = 3
      user_word.save

      user_word_2 = UserWord.create!(user: user, word: word_2)
      user_word_2.games_completed = 3
      user_word_2.save

      user_word_3 = UserWord.create!(user: user, word: word_3)
      user_word_3.games_completed = 3
      user_word_3.save

      user.goal = 10

      expect(goal_percentage_completion(user)).to eq(30)
    end

    it "returns 60" do
      user_word.games_completed = 3
      user_word.save

      user_word_2 = UserWord.create!(user: user, word: word_2)
      user_word_2.games_completed = 3
      user_word_2.save

      user_word_3 = UserWord.create!(user: user, word: word_3)
      user_word_3.games_completed = 3
      user_word_3.save

      user.goal = 5

      expect(goal_percentage_completion(user)).to eq(60)
    end

    it "returns 100" do
      user_word.games_completed = 3
      user_word.save

      user.goal = 1

      expect(goal_percentage_completion(user)).to eq(100)
    end
  end

  describe "#calculate_streak" do
    it "returns 0" do
      expect(calculate_streak(user)).to eq(0)
    end

    it "returns 0" do
      user_word_2 = UserWord.create!(user: user, word: word_2)
      user_word_3 = UserWord.create!(user: user, word: word_3)

      user_word.games_completed = 3
      user_word.updated_at = 2.day.ago
      user_word.save

      user_word_2.games_completed = 3
      user_word_2.updated_at = 3.days.ago
      user_word_2.save

      user_word_3.games_completed = 3
      user_word_3.updated_at = 4.days.ago
      user_word_3.save

      expect(calculate_streak(user)).to eq(0)
    end

    it "returns 1" do
      user_word_2 = UserWord.create!(user: user, word: word_2)

      user_word.games_completed = 3
      user_word.updated_at = 1.day.ago
      user_word.save

      user_word_2.games_completed = 3
      user_word_2.updated_at = 3.days.ago
      user_word_2.save

      expect(calculate_streak(user)).to eq(1)
    end

    it "returns 1" do
      user_word_2 = UserWord.create!(user: user, word: word_2)

      user_word.games_completed = 3
      user_word.updated_at = Date.today
      user_word.save

      user_word_2.games_completed = 3
      user_word_2.updated_at = 3.days.ago
      user_word_2.save

      expect(calculate_streak(user)).to eq(1)
    end

    it "returns 2" do
      user_word_2 = UserWord.create!(user: user, word: word_2)
      user_word_3 = UserWord.create!(user: user, word: word_3)

      user_word.games_completed = 3
      user_word.updated_at = 1.day.ago
      user_word.save

      user_word_2.games_completed = 3
      user_word_2.updated_at = 2.days.ago
      user_word_2.save

      user_word_3.games_completed = 2
      user_word_3.updated_at = DateTime.now
      user_word_3.save

      expect(calculate_streak(user)).to eq(2)
    end

    it "returns 2" do
      user_word_2 = UserWord.create!(user: user, word: word_2)
      user_word_3 = UserWord.create!(user: user, word: word_3)

      user_word.games_completed = 3
      user_word.updated_at = 3.days.ago
      user_word.save

      user_word_2.games_completed = 3
      user_word_2.updated_at = 1.day.ago
      user_word_2.save

      user_word_3.games_completed = 3
      user_word_3.updated_at = DateTime.now
      user_word_3.save

      expect(calculate_streak(user)).to eq(2)
    end

    it "returns 3" do
      user_word_2 = UserWord.create!(user: user, word: word_2)
      user_word_3 = UserWord.create!(user: user, word: word_3)

      user_word.games_completed = 3
      user_word.updated_at = 1.day.ago
      user_word.save

      user_word_2.games_completed = 3
      user_word_2.updated_at = 2.days.ago
      user_word_2.save

      user_word_3.games_completed = 3
      user_word_3.updated_at = 3.days.ago
      user_word_3.save

      expect(calculate_streak(user)).to eq(3)
    end

    it "returns 4" do
      user_word_2 = UserWord.create!(user: user, word: word_2)
      user_word_3 = UserWord.create!(user: user, word: word_3)
      user_word_4 = UserWord.create!(user: user, word: word_4)

      user_word.games_completed = 3
      user_word.updated_at = 1.day.ago
      user_word.save

      user_word_2.games_completed = 3
      user_word_2.updated_at = 2.days.ago
      user_word_2.save

      user_word_3.games_completed = 3
      user_word_3.updated_at = 3.days.ago
      user_word_3.save

      user_word_4.games_completed = 3
      user_word_4.updated_at = 4.days.ago
      user_word_4.save

      expect(calculate_streak(user)).to eq(4)
    end
  end
end
