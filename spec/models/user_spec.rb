require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  let(:word) { FactoryGirl.create(:word) }
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
    it { should have_many(:reviews) }
    it { should have_many(:feedbacks) }
  end

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_length_of(:username).is_at_least(3) }
    it { should validate_length_of(:username).is_at_most(33) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_presence_of(:points) }
    it { should validate_length_of(:first_name).is_at_most(50) }
    it { should validate_length_of(:last_name).is_at_most(50) }
    xit { should validate_uniqueness_of(:email).case_insensitive.allow_blank }
  end

  describe "#initialization" do
    it "returns a username string" do
      expect(user.username).to include("foobar")
    end

    it "returns a password string" do
      expect(user.password).to eq("password")
    end

    it "returns a password string" do
      expect(user.password_confirmation).to eq("password")
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

  describe "#already_has_word?" do
    it "returns false" do
      expect(user.already_has_word?(word)).to eq(false)
    end

    it "returns true" do
      user.words << word

      expect(user.already_has_word?(word)).to eq(true)
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

  describe "#has_user_word_tags?" do
    it "returns false" do
      expect(user.has_user_word_tags?).to eq(false)
    end

    it "returns true" do
      user.user_word_tags << user_word_tag

      expect(user.has_user_word_tags?).to eq(true)
    end
  end

  describe "#already_has_tag?" do
    it "returns false" do
      expect(user.already_has_tag?("foobar")).to eq(false)
    end

    it "returns true" do
      user.tags << tag

      expect(user.already_has_tag?(tag)).to eq(true)
    end
  end

  describe "#is_admin?" do
    it "returns false" do
      expect(user.is_admin?).to eq(false)
    end

    it "returns true" do
      user.role = "admin"

      expect(user.is_admin?).to eq(true)
    end
  end

  describe "#is_teacher?" do
    it "returns false" do
      expect(user.is_teacher?).to eq(false)
    end

    it "returns true" do
      user.role = "admin"

      expect(user.is_teacher?).to eq(true)
    end

    it "returns true" do
      user.role = "teacher"

      expect(user.is_teacher?).to eq(true)
    end
  end

  describe "#is_student?" do
    it "returns false" do
      expect(user.is_student?).to eq(false)
    end

    it "returns true" do
      user.role = "admin"

      expect(user.is_student?).to eq(false)
    end

    it "returns true" do
      user.role = "teacher"

      expect(user.is_student?).to eq(false)
    end

    it "returns true" do
      user.role = "student"

      expect(user.is_student?).to eq(true)
    end
  end

  describe "#can_create_words?" do
    it "returns false" do
      expect(user.can_create_words?).to eq(false)
    end

    it "returns true" do
      user.role = "admin"

      expect(user.can_create_words?).to eq(true)
    end

    it "returns true" do
      user.role = "teacher"

      expect(user.can_create_words?).to eq(true)
    end
  end

  describe "#self.top_ten_highest_points?" do
    it "returns false" do
      user.points = 1
      user_2 = FactoryGirl.create(:user, points: 2)
      user_3 = FactoryGirl.create(:user, points: 3)
      user_4 = FactoryGirl.create(:user, points: 4)
      user_5 = FactoryGirl.create(:user, points: 5)
      user_6 = FactoryGirl.create(:user, points: 6)
      user_7 = FactoryGirl.create(:user, points: 7)
      user_8 = FactoryGirl.create(:user, points: 8)
      user_9 = FactoryGirl.create(:user, points: 9)
      user_10 = FactoryGirl.create(:user, points: 10)
      user_11 = FactoryGirl.create(:user, points: 11)
      user_12 = FactoryGirl.create(:user, points: 12)
      user_13 = FactoryGirl.create(:user, points: 13)
      user_14 = FactoryGirl.create(:user, points: 0)
      user_15 = FactoryGirl.create(:user, points: 100)

      expect(User.top_ten_highest_points.count).to eq(10)
      expect(User.top_ten_highest_points.map { |u|
        u.points }.inject(:+)).to eq(181)
    end
  end

  describe "#incomplete_fundamentals" do
    let (:user) { FactoryGirl.create(:user) }

    it "returns 3 incomplete Fundamental UW objects" do
      word = Word.create(name: "foobar", definition: "foo+bar=foobar")
      word_2 = Word.create(name: "foobar_2", definition: "foo+bar=foobar 2")
      word_3 = Word.create(name: "foobar_3", definition: "foo+bar=foobar 3")

      UserWord.create!(word: word, user: user)
      UserWord.create!(word: word_2, user: user)
      UserWord.create!(word: word_3, user: user)

      expect(user.incomplete_fundamentals.count).to eq(3)
    end
  end

  describe "#incomplete_jeopardys" do
    let (:user) { FactoryGirl.create(:user) }
    let(:word) { Word.create(name: "foobar", definition: "foobar def") }
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns 3 incomplete Jeopardy UW objects" do
      user_word = UserWord.create!(word: word, user: user,
        games_completed: 1
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
        games_completed: 1
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
        games_completed: 1
      )

      expect(user.incomplete_jeopardys.count).to eq(3)
    end
  end

  describe "#incomplete_freestyles" do
    let (:user) { FactoryGirl.create(:user) }
    let(:word) { Word.create(name: "foobar", definition: "foobar def") }
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns 3 incomplete Freestyle UW objects" do
      user_word = UserWord.create!(word: word, user: user,
       games_completed: 2
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
       games_completed: 2
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
       games_completed: 2
      )

      expect(user.incomplete_freestyles.count).to eq(3)
    end
  end

  describe "#has_incomplete_fundamentals?" do
    let (:user) { FactoryGirl.create(:user) }
    let(:word) { Word.create(name: "foobar", definition: "foobar def") }
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns false" do
      user_word = UserWord.create!(word: word, user: user,
       games_completed: 1
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
       games_completed: 1
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
       games_completed: 1
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
    let (:user) { FactoryGirl.create(:user) }
    let(:word) { Word.create(name: "foobar", definition: "foobar def") }
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns false" do
      user_word = UserWord.create!(word: word, user: user,
        games_completed: 2
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
        games_completed: 2
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
        games_completed: 2
      )

      expect(user.has_incomplete_jeopardys?).to eq(false)
    end

    it "returns false" do
      user_word = UserWord.create!(word: word, user: user,
        games_completed: 3
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
        games_completed: 3
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
        games_completed: 3
      )

      expect(user.has_incomplete_jeopardys?).to eq(false)
    end

    it "returns true" do
      user_word = UserWord.create!(word: word, user: user,
        games_completed: 1
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
        games_completed: 1
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
        games_completed: 1
      )

      expect(user.has_incomplete_jeopardys?).to eq(true)
    end
  end

  describe "#has_incomplete_freestyles?" do
    let (:user) { FactoryGirl.create(:user) }
    let(:word) { Word.create(name: "foobar", definition: "foobar def") }
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns false" do
      user_word = UserWord.create!(word: word, user: user,
        games_completed: 3
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
        games_completed: 3
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
        games_completed: 3
      )

      expect(user.has_incomplete_freestyles?).to eq(false)
    end

    it "returns true" do
      user_word = UserWord.create!(word: word, user: user,
        games_completed: 2
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
        games_completed: 2
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
        games_completed: 2
      )

      expect(user.has_incomplete_freestyles?).to eq(true)
    end
  end

  describe "#completed_fundamentals" do
    let (:user) { FactoryGirl.create(:user) }

    it "returns 3 completed Fundamental UW objects" do
      word = Word.create(name: "foobar", definition: "foo+bar=foobar")
      word_2 = Word.create(name: "foobar_2", definition: "foo+bar=foobar 2")
      word_3 = Word.create(name: "foobar_3", definition: "foo+bar=foobar 3")

      UserWord.create!(word: word, user: user, games_completed: 1)
      UserWord.create!(word: word_2, user: user, games_completed: 1)
      UserWord.create!(word: word_3, user: user, games_completed: 1)

      expect(user.completed_fundamentals.count).to eq(3)
    end

    it "returns 3 completed Fundamental UW objects" do
      word = Word.create(name: "foobar", definition: "foo+bar=foobar")
      word_2 = Word.create(name: "foobar_2", definition: "foo+bar=foobar 2")
      word_3 = Word.create(name: "foobar_3", definition: "foo+bar=foobar 3")

      UserWord.create!(word: word, user: user, games_completed: 2)
      UserWord.create!(word: word_2, user: user, games_completed: 2)
      UserWord.create!(word: word_3, user: user, games_completed: 2)

      expect(user.completed_fundamentals.count).to eq(3)
    end

    it "returns 3 completed Fundamental UW objects" do
      word = Word.create(name: "foobar", definition: "foo+bar=foobar")
      word_2 = Word.create(name: "foobar_2", definition: "foo+bar=foobar 2")
      word_3 = Word.create(name: "foobar_3", definition: "foo+bar=foobar 3")

      UserWord.create!(word: word, user: user, games_completed: 3)
      UserWord.create!(word: word_2, user: user, games_completed: 3)
      UserWord.create!(word: word_3, user: user, games_completed: 3)

      expect(user.completed_fundamentals.count).to eq(3)
    end

    it "returns 3 completed Fundamental UW objects" do
      word = Word.create(name: "foobar", definition: "foo+bar=foobar")
      word_2 = Word.create(name: "foobar_2", definition: "foo+bar=foobar 2")
      word_3 = Word.create(name: "foobar_3", definition: "foo+bar=foobar 3")

      UserWord.create!(word: word, user: user, games_completed: 1)
      UserWord.create!(word: word_2, user: user, games_completed: 2)
      UserWord.create!(word: word_3, user: user, games_completed: 3)

      expect(user.completed_fundamentals.count).to eq(3)
    end
  end

  describe "#completed_jeopardys" do
    let (:user) { FactoryGirl.create(:user) }
    let(:word) { Word.create(name: "foobar", definition: "foobar def") }
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns 3 completed Jeopardy UW objects" do
      user_word = UserWord.create!(word: word, user: user,
        games_completed: 2
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
        games_completed: 2
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
        games_completed: 2
      )

      expect(user.completed_jeopardys.count).to eq(3)
    end

    it "returns 3 completed Jeopardy UW objects" do
      user_word = UserWord.create!(word: word, user: user,
        games_completed: 2
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
        games_completed: 3
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
        games_completed: 3
      )

      expect(user.completed_jeopardys.count).to eq(3)
    end
  end

  describe "#completed_freestyles" do
    let (:user) { FactoryGirl.create(:user) }
    let(:word) { Word.create(name: "foobar", definition: "foobar def") }
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns 3 completed Freestyle UW objects" do
      user_word = UserWord.create!(word: word, user: user,
       games_completed: 3
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
       games_completed: 3
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
       games_completed: 3
      )

      expect(user.completed_freestyles.count).to eq(3)
    end
  end

  describe "#has_completed_fundamentals?" do
    let (:user) { FactoryGirl.create(:user) }
    let(:word) { Word.create(name: "foobar", definition: "foobar def") }
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns true" do
      user_word = UserWord.create!(word: word, user: user,
       games_completed: 1
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
       games_completed: 1
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
       games_completed: 1
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

  describe "#has_completed_jeopardys?" do
    let (:user) { FactoryGirl.create(:user) }
    let(:word) { Word.create(name: "foobar", definition: "foobar def") }
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns true" do
      user_word = UserWord.create!(word: word, user: user,
        games_completed: 2
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
        games_completed: 2
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
        games_completed: 2
      )

      expect(user.has_completed_jeopardys?).to eq(true)
    end

    it "returns true" do
      user_word = UserWord.create!(word: word, user: user,
        games_completed: 3
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
        games_completed: 3
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
        games_completed: 3
      )

      expect(user.has_completed_jeopardys?).to eq(true)
    end

    it "returns false" do
      user_word = UserWord.create!(word: word, user: user,
        games_completed: 1
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
        games_completed: 1
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
        games_completed: 1
      )

      expect(user.has_completed_jeopardys?).to eq(false)
    end
  end

  describe "#has_completed_freestyles?" do
    let (:user) { FactoryGirl.create(:user) }
    let(:word) { Word.create(name: "foobar", definition: "foobar def") }
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }

    it "returns true" do
      user_word = UserWord.create!(word: word, user: user,
        games_completed: 3
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
        games_completed: 3
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
        games_completed: 3
      )

      expect(user.has_completed_freestyles?).to eq(true)
    end

    it "returns false" do
      user_word = UserWord.create!(word: word, user: user,
        games_completed: 2
      )
      user_word_2 = UserWord.create!(word: word_2, user: user,
        games_completed: 1
      )
      user_word_3 = UserWord.create!(word: word_3, user: user,
        games_completed: 2
      )

      expect(user.has_completed_freestyles?).to eq(false)
    end
  end

  describe "#has_games_to_play?" do
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }
    let (:user_word_1) { UserWord.create!(user: user, word: word) }
    let (:user_word_2) { UserWord.create!(user: user, word: word_2) }
    let (:user_word_3) { UserWord.create!(user: user, word: word_3) }

    it "returns false" do
      user_word_1.games_completed = 3
      user_word_1.save
      user_word_2.games_completed = 3
      user_word_2.save
      user_word_3.games_completed = 3
      user_word_3.save

      expect(user.has_games_to_play?).to eq(false)
    end

    it "returns true" do
      user_word_1.games_completed = 0
      user_word_1.save
      user_word_2.games_completed = 1
      user_word_2.save
      user_word_3.games_completed = 2
      user_word_3.save

      expect(user.has_games_to_play?).to eq(true)
    end

    it "returns true" do
      user_word_1.games_completed = 1
      user_word_1.save
      user_word_2.games_completed = 3
      user_word_2.save
      user_word_3.games_completed = 3
      user_word_3.save

      expect(user.has_games_to_play?).to eq(true)
    end

    it "returns true" do
      user_word_1.games_completed = 2
      user_word_1.save
      user_word_2.games_completed = 3
      user_word_2.save
      user_word_3.games_completed = 3
      user_word_3.save

      expect(user.has_games_to_play?).to eq(true)
    end
  end

  describe "#has_enough_jeopardy_words?" do
    let (:user) { FactoryGirl.create(:user) }
    let(:word) { Word.create(name: "foobar", definition: "foobar def") }
    let(:word_2) { Word.create(name: "foobar_2", definition: "foobar def_2") }
    let(:word_3) { Word.create(name: "foobar_3", definition: "foobar def_3") }
    let(:word_4) { Word.create(name: "foobar_3", definition: "foobar def_4") }

    it "returns false" do
      user_word = UserWord.create!(word: word, user: user)
      user_word_2 = UserWord.create!(word: word_2, user: user)
      user_word_3 = UserWord.create!(word: word_3, user: user)

      expect(user.has_enough_jeopardy_words?).to eq(false)
    end

    it "returns false" do
      UserWord.create!(word: word, user: user, games_completed: 1)
      UserWord.create!(word: word_2, user: user, games_completed: 1)
      UserWord.create!(word: word_3, user: user, games_completed: 1)

      expect(user.has_enough_jeopardy_words?).to eq(false)
    end

    it "returns true" do
      UserWord.create!(word: word, user: user, games_completed: 2)
      UserWord.create!(word: word_2, user: user, games_completed: 2)
      UserWord.create!(word: word_3, user: user, games_completed: 2)
      UserWord.create!(word: word_4, user: user, games_completed: 2)

      expect(user.has_enough_jeopardy_words?).to eq(true)
    end

    it "returns true" do
      UserWord.create!(word: word, user: user, games_completed: 3)
      UserWord.create!(word: word_2, user: user, games_completed: 3)
      UserWord.create!(word: word_3, user: user, games_completed: 3)
      UserWord.create!(word: word_4, user: user, games_completed: 3)

      expect(user.has_enough_jeopardy_words?).to eq(true)
    end

    it "returns true" do
      UserWord.create!(word: word, user: user, games_completed: 2)
      UserWord.create!(word: word_2, user: user, games_completed: 3)
      UserWord.create!(word: word_3, user: user, games_completed: 2)
      UserWord.create!(word: word_4, user: user, games_completed: 3)

      expect(user.has_enough_jeopardy_words?).to eq(true)
    end
  end

  describe "#last_login_nil?" do
    let (:user) { FactoryGirl.create(:user) }

    it "returns true" do
      expect(user.last_login_nil?).to eq(true)
    end

    it "returns false" do
      user.last_login = DateTime.now

      expect(user.last_login_nil?).to eq(false)
    end
  end

  pending "#words_added_last_day" do
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

  pending "#fundamentals_completed_yesterday" do
    it "returns 0 UW objects" do
      expect(user.fundamentals_completed_yesterday).to eq(0)
    end

    it "returns 1 UW object" do
      expect(user.fundamentals_completed_yesterday).to eq(1)
    end

    it "returns 2 UW objects" do
      expect(user.fundamentals_completed_yesterday).to eq(2)
    end

    it "returns 3 UW objects" do
      expect(user.fundamentals_completed_yesterday).to eq(3)
    end
  end

  pending "#jeopardys_completed_yesterday" do
    it "returns 0 UW objects" do
      expect(user.jeopardys_completed_yesterday).to eq(0)
    end

    it "returns 1 UW object" do
      expect(user.jeopardys_completed_yesterday).to eq(1)
    end

    it "returns 2 UW objects" do
      expect(user.jeopardys_completed_yesterday).to eq(2)
    end

    it "returns 3 UW objects" do
      expect(user.jeopardys_completed_yesterday).to eq(3)
    end
  end

  pending "#freestyles_completed_yesterday" do
    it "returns 0 UW objects" do
      expect(user.freestyles_completed_yesterday).to eq(0)
    end

    it "returns 1 UW object" do
      expect(user.freestyles_completed_yesterday).to eq(1)
    end

    it "returns 2 UW objects" do
      expect(user.freestyles_completed_yesterday).to eq(2)
    end

    it "returns 3 UW objects" do
      expect(user.freestyles_completed_yesterday).to eq(3)
    end
  end

  pending "#freestyles_completed_today" do
    it "returns 0 UW objects" do
      expect(user.freestyles_completed_today).to eq(0)
    end

    it "returns 1 UW object" do
      expect(user.freestyles_completed_today).to eq(1)
    end

    it "returns 2 UW objects" do
      expect(user.freestyles_completed_today).to eq(2)
    end

    it "returns 3 UW objects" do
      expect(user.freestyles_completed_today).to eq(3)
    end
  end

  pending "#has_recent_activity?" do
    it "returns true" do
      expect(user.has_recent_activity?).to eq(true)
    end

    it "returns false" do
      expect(user.has_recent_activity?).to eq(false)
    end
  end

  pending "#has_completed_freestyle_yesterday_or_today?" do
    it "returns true" do
      expect(user.has_completed_freestyle_yesterday_or_today?).to eq(true)
    end

    it "returns false" do
      expect(user.has_completed_freestyle_yesterday_or_today?).to eq(false)
    end
  end

  pending "#completed_freestyle_on?" do
    it "returns true" do
      expect(user.completed_freestyle_on?(date)).to eq(true)
    end

    it "returns false" do
      expect(user.completed_freestyle_on?(date)).to eq(false)
    end
  end
end
