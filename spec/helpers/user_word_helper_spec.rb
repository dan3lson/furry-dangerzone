require 'rails_helper'

RSpec.describe UserWordHelper, type: :helper do

  describe "#ready_for_jeopardy?" do
    let(:user_word) { FactoryGirl.create(:user_word) }
    let(:user) { user_word.user }
    let(:word) { user_word.word }

    it "returns true (all jeopardy-ready words)" do
      word_2 = Word.create!(name: "foobar_2", definition: "foobar_2_def")
      word_3 = Word.create!(name: "foobar_3", definition: "foobar_3_def")
      word_4 = Word.create!(name: "foobar_4", definition: "foobar_4_def")

      user_word.games_completed = 1
      user_word.save

      user_word_2 = UserWord.create!(user: user, word: word_2,
        games_completed: 1
      )
      user_word_3 = UserWord.create!(user: user, word: word_3,
        games_completed: 1
      )
      user_word_4 = UserWord.create!(user: user, word: word_4,
        games_completed: 1
      )

      expect(ready_for_jeopardy?(user, user_word)).to eq(true)
      expect(ready_for_jeopardy?(user, user_word_2)).to eq(true)
      expect(ready_for_jeopardy?(user, user_word_3)).to eq(true)
      expect(ready_for_jeopardy?(user, user_word_4)).to eq(true)
    end

    it "returns false" do
      expect(ready_for_jeopardy?(user, user_word)).to eq(false)
    end

    it "returns false" do
      user_word.games_completed = 1

      expect(ready_for_jeopardy?(user, user_word)).to eq(false)
    end

    it "returns false" do
      user_word.games_completed = 2

      expect(ready_for_jeopardy?(user, user_word)).to eq(false)
    end

    it "returns false" do
      user_word.games_completed = 3

      expect(ready_for_jeopardy?(user, user_word)).to eq(false)
    end

    it "returns false" do
      word_2 = Word.create!(name: "foobar_2", definition: "foobar_2_def")
      word_3 = Word.create!(name: "foobar_3", definition: "foobar_3_def")
      word_4 = Word.create!(name: "foobar_4", definition: "foobar_4_def")

      user_word.games_completed = 1
      user_word.save

      user_word_2 = UserWord.create!(user: user, word: word_2,
        games_completed: 2
      )
      user_word_3 = UserWord.create!(user: user, word: word_3,
        games_completed: 2
      )
      user_word_4 = UserWord.create!(user: user, word: word_4,
        games_completed: 3
      )

      expect(ready_for_jeopardy?(user, user_word_2)).to eq(false)
      expect(ready_for_jeopardy?(user, user_word_3)).to eq(false)
      expect(ready_for_jeopardy?(user, user_word_4)).to eq(false)
    end
  end
end
