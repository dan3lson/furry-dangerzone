require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  let(:word) { FactoryGirl.create(:word) }
  let(:word_2) { FactoryGirl.create(:word) }
  let(:word_3) { FactoryGirl.create(:word) }
  let(:word_4) { FactoryGirl.create(:word) }
  let!(:tag) { FactoryGirl.create(:tag) }
  let!(:word_tag) { WordTag.create(word: word, tag: tag) }
  let(:user_word_tag) { UserWordTag.create!(user: user, word_tag: word_tag) }

  describe "associatons" do
    it { should have_many(:user_words) }
    it { should have_many(:words) }
    it { should have_many(:user_tags) }
    it { should have_many(:tags) }
    it { should have_many(:user_word_tags) }
    it { should have_many(:word_tags) }
  end

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_length_of(:username).is_at_least(3) }
    it { should validate_length_of(:username).is_at_most(33) }
    it { should validate_presence_of(:password) }
      it { should validate_length_of(:password).is_at_least(6) }
    it { should have_secure_password }
    it { should validate_length_of(:first_name).is_at_most(50) }
    it { should validate_length_of(:last_name).is_at_most(50) }
  end

  describe "#initialization" do
    it "returns a username string" do
      expect(user.username).to include("user")
    end

    it "returns a password string" do
      expect(user.password).to eq("password")
    end

    it "returns a password string" do
      expect(user.password_confirmation).to eq("password")
    end
  end

  describe "#has_email_address?" do
    it "returns true" do
      expect(user.has_email_address?).to eq(true)
    end

    it "returns false" do
      user.email = nil

      expect(user.has_email_address?).to eq(false)
    end
  end

  describe "#has_word?" do
    it "returns false" do
      expect(user.has_word?(word)).to eq(false)
    end

    it "returns true" do
      user.words << word

      expect(user.has_word?(word)).to eq(true)
    end
  end

  describe "#has_words?" do
    it "returns false" do
      expect(user.has_words?).to eq(false)
    end

    it "returns true" do
      user.words << word

      expect(user.has_words?).to eq(true)
    end
  end

  describe "#has_tag?" do
    it "returns false" do
      expect(user.has_tag?(tag)).to eq(false)
    end

    it "returns true" do
      user.tags << tag

      expect(user.has_tag?(tag)).to eq(true)
    end
  end

  describe "#has_tags?" do
    it "returns false" do
      expect(user.has_tags?).to eq(false)
    end

    it "returns true" do
      user.tags << tag

      expect(user.has_tags?).to eq(true)
    end
  end

  describe "#is_admin?" do
    it "returns false" do
      expect(user.is_admin?).to eq(false)
    end

    it "returns true" do
      user.type = "Admin"

      expect(user.is_admin?).to eq(true)
    end
  end

  describe "#is_teacher?" do
    it "returns false" do
      expect(user.is_teacher?).to eq(false)
    end

    it "returns true" do
      user.type = "Admin"

      expect(user.is_teacher?).to eq(true)
    end

    it "returns true" do
      user.type = "Teacher"

      expect(user.is_teacher?).to eq(true)
    end
  end

  describe "#is_student?" do
    it "returns false given :type default" do
      expect(user.is_student?).to eq(true)
    end

    it "returns true if :type is Admin" do
      user.type = "Admin"

      expect(user.is_student?).to eq(true)
    end

    it "returns true if :type is Teacher" do
      user.type = "Teacher"

      expect(user.is_student?).to eq(true)
    end

    it "returns true given :type is Student" do
      user.type = "Student"

      expect(user.is_student?).to eq(true)
    end
  end

  describe "#incomplete_fundamentals" do
    it "returns 3 incomplete Fundamental UW objects" do
      UserWord.create!(word: word, user: user)
      UserWord.create!(word: word_2, user: user)
      UserWord.create!(word: word_3, user: user)

      expect(user.incomplete_fundamentals.count).to eq(3)
    end
  end

  describe "#incomplete_jeopardys" do
    it "returns 2 incomplete Jeopardy UW objects" do
      user_word = UserWord.create!(word: word, user: user,
        games_completed: 6
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
        games_completed: 7
      )

      expect(user.incomplete_jeopardys.count).to eq(2)
    end
  end

  describe "#incomplete_freestyles" do
    it "returns 4 incomplete Freestyle UW objects" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 8
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 9
      )
      user_word_3 = UserWord.create!(
        word: word_3,
        user: user,
        games_completed: 10
      )
      user_word_4 = UserWord.create!(
        word: word_4,
        user: user,
        games_completed: 11
      )

      expect(user.incomplete_freestyles.count).to eq(4)
    end
  end

  describe "#incomplete_words" do
    it "returns 4 incomplete words" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 2
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 6
      )
      user_word_3 = UserWord.create!(
        word: word_3,
        user: user,
        games_completed: 10
      )
      user_word_4 = UserWord.create!(
        word: word_4,
        user: user,
        games_completed: 11
      )
      expect(user.incomplete_words.count).to eq(4)
    end

    it "returns 1 incomplete fundamentals" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 2
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 6
      )
      user_word_3 = UserWord.create!(
        word: word_3,
        user: user,
        games_completed: 10
      )
      user_word_4 = UserWord.create!(
        word: word_4,
        user: user,
        games_completed: 11
      )
      incomplete_funds = user.incomplete_words
                             .map(&:games_completed)
                             .keep_if { |n| n < 6 }
      expect(incomplete_funds.count).to eq(1)
    end

    it "returns 1 incomplete jeopardy" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 2
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 6
      )
      user_word_3 = UserWord.create!(
        word: word_3,
        user: user,
        games_completed: 10
      )
      user_word_4 = UserWord.create!(
        word: word_4,
        user: user,
        games_completed: 11
      )
      incomplete_jeops = user.incomplete_words
                             .map(&:games_completed)
                             .keep_if { |n| [6, 7].include?(n) }
      expect(incomplete_jeops.count).to eq(1)
    end

    it "returns 2 incomplete jeopardy" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 2
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 6
      )
      user_word_3 = UserWord.create!(
        word: word_3,
        user: user,
        games_completed: 10
      )
      user_word_4 = UserWord.create!(
        word: word_4,
        user: user,
        games_completed: 11
      )
      incomplete_frees = user.incomplete_words
                             .map(&:games_completed)
                             .keep_if { |n| [8, 9, 10, 11].include?(n) }
      expect(incomplete_frees.count).to eq(2)
    end
  end

  describe "#has_incomplete_word?" do
    it "returns true" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 2
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 10
      )

      expect(user.has_incomplete_word?).to eq(true)
    end

    it "returns false" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 12
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 15
      )

      expect(user.has_incomplete_word?).to eq(false)
    end
  end

  describe "#has_incomplete_words_not?" do
    it "returns true when incomplete words minus given word exists" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 2
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 10
      )

      expect(user.has_incomplete_words_not?(word_2)).to eq(true)
    end

    it "returns false when incomplete words minus given word does not exist" do
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 15
      )

      expect(user.has_incomplete_words_not?(word_2)).to eq(false)
    end
  end

  describe "#rand_incomplete_word" do
    it "returns class UserWord for randomly returned object" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 2
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 10
      )

      expect(user.rand_incomplete_word.class).to eq(UserWord)
    end

    it "returns incomplete UserWord" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 6
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 15
      )

      expect(user.rand_incomplete_word.class).to eq(UserWord)
      expect(user.rand_incomplete_word.games_completed).to eq(6)
    end
  end

  describe "#has_rand_incomplete_word?" do
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns true" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 2
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 10
      )

      expect(user.has_rand_incomplete_word?).to eq(true)
    end

    it "returns false with completed words" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 12
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 15
      )

      expect(user.has_rand_incomplete_word?).to eq(false)
    end

    it "returns false with no words" do
      expect(user.has_rand_incomplete_word?).to eq(false)
    end
  end

  describe "#has_incomplete_fundamentals?" do
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns false" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 6
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 10
      )
      user_word_3 = UserWord.create!(
        word: word_3,
        user: user,
        games_completed: 15
      )

      expect(user.has_incomplete_fundamentals?).to eq(false)
    end

    it "returns true" do
      user_word = UserWord.create!(word: word, user: user)
      user_word_2 = UserWord.create!(word: word_2, user: user)
      user_word_3 = UserWord.create!(word: word_3, user: user)

      expect(user.has_incomplete_fundamentals?).to eq(true)
    end
  end

  describe "#has_incomplete_jeopardys?" do
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns false" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 1
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 3
      )
      user_word_3 = UserWord.create!(
        word: word_3,
        user: user,
        games_completed: 5
      )

      expect(user.has_incomplete_jeopardys?).to eq(false)
    end

    it "returns true" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 6
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 7
      )

      expect(user.has_incomplete_jeopardys?).to eq(true)
    end
  end

  describe "#has_incomplete_freestyles?" do
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns false" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 3
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 6
      )
      user_word_3 = UserWord.create!(
        word: word_3,
        user: user,
        games_completed: 14
      )

      expect(user.has_incomplete_freestyles?).to eq(false)
    end

    it "returns true" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 8
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 10
      )
      user_word_3 = UserWord.create!(
        word: word_3,
        user: user,
        games_completed: 11
      )

      expect(user.has_incomplete_freestyles?).to eq(true)
    end
  end

  describe "#completed_fundamentals" do
    it "returns 3 completed Fundamental UW objects" do
      word_2 = Word.create(name: "foobar_2", definition: "foo+bar=foobar 2")
      word_3 = Word.create(name: "foobar_3", definition: "foo+bar=foobar 3")
      word_4 = Word.create(name: "foobar_4", definition: "foo+bar=foobar 4")

      UserWord.create!(word: word, user: user, games_completed: 6)
      UserWord.create!(word: word_2, user: user, games_completed: 7)
      UserWord.create!(word: word_3, user: user, games_completed: 13)
      UserWord.create!(word: word_4, user: user, games_completed: 200)

      expect(user.completed_fundamentals.count).to eq(4)
    end
  end

  describe "#completed_jeopardys" do
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns 3 completed Jeopardy UW objects" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 8
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 10
      )
      user_word_3 = UserWord.create!(
        word: word_3,
        user: user,
        games_completed: 14
      )

      expect(user.completed_jeopardys.count).to eq(3)
    end
  end

  describe "#completed_freestyles" do
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns 3 completed Freestyle UW objects" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 12
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 13
      )
      user_word_3 = UserWord.create!(
        word: word_3,
        user: user,
        games_completed: 31
      )

      expect(user.completed_freestyles.count).to eq(3)
    end
  end

  describe "#has_completed_fundamentals?" do
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns true" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 2
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 10
      )
      user_word_3 = UserWord.create!(
        word: word_3,
        user: user,
        games_completed: 15
      )

      expect(user.has_completed_fundamentals?).to eq(true)
    end

    it "returns false" do
      user_word = UserWord.create!(word: word, user: user)
      user_word_2 = UserWord.create!(word: word_2, user: user)
      user_word_3 = UserWord.create!(word: word_3, user: user)

      expect(user.has_completed_fundamentals?).to eq(false)
    end
  end

  describe "#has_completed_freestyles?" do
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns true" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 3
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 12
      )
      user_word_3 = UserWord.create!(
        word: word_3,
        user: user,
        games_completed: 14
      )

      expect(user.has_completed_freestyles?).to eq(true)
    end

    it "returns false" do
      user_word = UserWord.create!(
        word: word,
        user: user,
        games_completed: 2
      )
      user_word_2 = UserWord.create!(
        word: word_2,
        user: user,
        games_completed: 8
      )
      user_word_3 = UserWord.create!(
        word: word_3,
        user: user,
        games_completed: 11
      )

      expect(user.has_completed_freestyles?).to eq(false)
    end
  end

  describe "#has_enough_incomplete_jeops?" do
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }
    let(:word_4) { Word.create(name: "foobar_3", definition: "foobar def_4") }

    it "returns false" do
      user_word = UserWord.create!(word: word, user: user)

      expect(user.has_enough_incomplete_jeops?).to eq(false)
    end

    it "returns true" do
      UserWord.create!(word: word, user: user, games_completed: 6)
      UserWord.create!(word: word_2, user: user, games_completed: 7)

      expect(user.has_enough_incomplete_jeops?).to eq(true)
    end

    it "returns true" do
      UserWord.create!(word: word, user: user, games_completed: 3)
      UserWord.create!(word: word_2, user: user, games_completed: 6)

      expect(user.has_enough_incomplete_jeops?).to eq(false)
    end
  end

  skip "#words_added_last_day" do
    it "returns 0 UW objects" do
      expect(user.words_added_last_day).to eq(0)
    end

    it "returns 1 UW object" do
      expect(user.words_added_last_day).to eq(1)
    end

    it "returns 2 UW objects" do
      expect(user.words_added_last_day).to eq(2)
    end

    it "returns 3 UW objects" do
      expect(user.words_added_last_day).to eq(3)
    end
  end

  skip "#frees_compl_last_24_hrs" do
    it "returns 0 UW objects" do
      expect(user.frees_compl_last_24_hrs).to eq(0)
    end

    it "returns 1 UW object" do
      expect(user.frees_compl_last_24_hrs).to eq(1)
    end

    it "returns 2 UW objects" do
      expect(user.frees_compl_last_24_hrs).to eq(2)
    end

    it "returns 3 UW objects" do
      expect(user.frees_compl_last_24_hrs).to eq(3)
    end
  end

  skip "#has_recent_activity?" do
    it "returns true" do
      expect(user.has_recent_activity?).to eq(true)
    end

    it "returns false" do
      expect(user.has_recent_activity?).to eq(false)
    end
  end

  skip "#completed_freestyle_on?" do
    it "returns true" do
      expect(user.completed_freestyle_on?(date)).to eq(true)
    end

    it "returns false" do
      expect(user.completed_freestyle_on?(date)).to eq(false)
    end
  end
end
