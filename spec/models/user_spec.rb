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

  describe "#incomplete_fundamentals?" do
    it "returns 3 incomplete Fundamental UW objects" do
      user = User.create(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password",
        email: ""
      )

      word = Word.create(
        name: "foobar",
        definition: "foo plus bar equals foobar"
      )
      word_2 = Word.create(
        name: "foobar_2",
        definition: "foo plus bar equals foobar 2"
      )
      word_3 = Word.create(
        name: "foobar_3",
        definition: "foo plus bar equals foobar 3"
      )

      user_word = UserWord.create!(word: word, user: user)
      user_word_2 = UserWord.create!(word: word_2, user: user)
      user_word_3 = UserWord.create!(word: word_3, user: user)

      game_fundamental = Game.create!(
        name: "Fundamentals",
        description: "Be creative"
      )

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)

      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_8)

      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_8)

      expect(user.incomplete_fundamentals.count).to eq(3)
    end
  end

  describe "#incomplete_jeopardys?" do
    it "returns 3 incomplete Jeopardy UW objects" do
      user = User.create(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password",
        email: ""
      )

      word = Word.create(
        name: "foobar",
        definition: "foo plus bar equals foobar"
      )
      word_2 = Word.create(
        name: "foobar_2",
        definition: "foo plus bar equals foobar 2"
      )
      word_3 = Word.create(
        name: "foobar_3",
        definition: "foo plus bar equals foobar 3"
      )

      user_word = UserWord.create!(word: word, user: user)
      user_word_2 = UserWord.create!(word: word_2, user: user)
      user_word_3 = UserWord.create!(word: word_3, user: user)

      game_fundamental = Game.create!(
        name: "Fundamentals",
        description: "Be creative"
      )

      game_jeopardy = Game.create!(
        name: "Jeopardy",
        description: "Be creative"
      )

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)

      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_28)

      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_28)

      user_word.uwgl_fundamentals.each do |uw|
        uw.status = "complete"
        uw.save
      end

      user_word_2.uwgl_fundamentals.each do |uw|
        uw.status = "complete"
        uw.save
      end

      user_word_3.uwgl_fundamentals.each do |uw|
        uw.status = "complete"
        uw.save
      end

      expect(user.incomplete_jeopardys.count).to eq(3)
    end
  end

  describe "#incomplete_freestyles?" do
    it "returns 3 incomplete Freestyle UW objects" do
      user = User.create(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password",
        email: ""
      )

      word = Word.create(
        name: "foobar",
        definition: "foo plus bar equals foobar"
      )
      word_2 = Word.create(
        name: "foobar_2",
        definition: "foo plus bar equals foobar 2"
      )
      word_3 = Word.create(
        name: "foobar_3",
        definition: "foo plus bar equals foobar 3"
      )

      user_word = UserWord.create!(word: word, user: user)
      user_word_2 = UserWord.create!(word: word_2, user: user)
      user_word_3 = UserWord.create!(word: word_3, user: user)

      game_fundamental = Game.create!(
        name: "Fundamentals",
        description: "Be creative"
      )

      game_jeopardy = Game.create!(
        name: "Jeopardy",
        description: "Be creative"
      )

      game_freestyle = Game.create!(
        name: "Freestyle",
        description: "Be creative"
      )

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )
      level_29 = Level.create!(
        focus: "Freestyle focus 29",
        direction: "Direction"
      )
      level_30 = Level.create!(
        focus: "Freestyle focus 30",
        direction: "Direction"
      )
      level_31 = Level.create!(
        focus: "Freestyle focus 31",
        direction: "Direction"
      )
      level_32 = Level.create!(
        focus: "Freestyle focus 32",
        direction: "Direction"
      )
      level_33 = Level.create!(
        focus: "Freestyle focus 33",
        direction: "Direction"
      )
      level_34 = Level.create!(
        focus: "Freestyle focus 34",
        direction: "Type the word below:"
      )
      level_35 = Level.create!(
        focus: "Freestyle focus 35",
        direction: "Direction"
      )
      level_36 = Level.create!(
        focus: "Freestyle focus 36",
        direction: "Direction"
      )
      level_37 = Level.create!(
        focus: "Freestyle focus 37",
        direction: "Direction"
      )
      level_38 = Level.create!(
        focus: "Freestyle focus 38",
        direction: "Direction"
      )
      level_39 = Level.create!(
        focus: "Freestyle focus 39",
        direction: "Direction"
      )
      level_40 = Level.create!(
        focus: "Freestyle focus 40",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)
      free_gl_29 = GameLevel.create!(game: game_freestyle, level: level_29)
      free_gl_30 = GameLevel.create!(game: game_freestyle, level: level_30)
      free_gl_31 = GameLevel.create!(game: game_freestyle, level: level_31)
      free_gl_32 = GameLevel.create!(game: game_freestyle, level: level_32)
      free_gl_33 = GameLevel.create!(game: game_freestyle, level: level_33)
      free_gl_34 = GameLevel.create!(game: game_freestyle, level: level_34)
      free_gl_35 = GameLevel.create!(game: game_freestyle, level: level_35)
      free_gl_36 = GameLevel.create!(game: game_freestyle, level: level_36)
      free_gl_37 = GameLevel.create!(game: game_freestyle, level: level_37)
      free_gl_38 = GameLevel.create!(game: game_freestyle, level: level_38)
      free_gl_39 = GameLevel.create!(game: game_freestyle, level: level_39)
      free_gl_40 = GameLevel.create!(game: game_freestyle, level: level_40)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_40)

      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_40)

      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_40)

      user_word.uwgl_fundamentals.each do |uw|
        uw.status = "complete"
        uw.save
      end

      user_word.uwgl_jeopardys.each do |uw|
        uw.status = "complete"
        uw.save
      end

      user_word_2.uwgl_fundamentals.each do |uw|
        uw.status = "complete"
        uw.save
      end

      user_word_2.uwgl_jeopardys.each do |uw|
        uw.status = "complete"
        uw.save
      end

      user_word_3.uwgl_fundamentals.each do |uw|
        uw.status = "complete"
        uw.save
      end

      user_word_3.uwgl_jeopardys.each do |uw|
        uw.status = "complete"
        uw.save
      end

      expect(user.incomplete_freestyles.count).to eq(3)
    end
  end

  describe "#has_incomplete_fundamentals?" do
    it "returns false" do
      user = User.create(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password",
        email: ""
      )

      word = Word.create(
        name: "foobar",
        definition: "foo plus bar equals foobar"
      )
      word_2 = Word.create(
        name: "foobar_2",
        definition: "foo plus bar equals foobar 2"
      )
      word_3 = Word.create(
        name: "foobar_3",
        definition: "foo plus bar equals foobar 3"
      )

      user_word = UserWord.create!(word: word, user: user)
      user_word_2 = UserWord.create!(word: word_2, user: user)
      user_word_3 = UserWord.create!(word: word_3, user: user)

      game_fundamental = Game.create!(
        name: "Fundamentals",
        description: "Be creative"
      )

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)

      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_8)

      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_8)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_2.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_3.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      expect(user.has_incomplete_fundamentals?).to eq(false)
    end

    it "returns true" do
      user = User.create(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password",
        email: ""
      )

      word = Word.create(
        name: "foobar",
        definition: "foo plus bar equals foobar"
      )
      word_2 = Word.create(
        name: "foobar_2",
        definition: "foo plus bar equals foobar 2"
      )
      word_3 = Word.create(
        name: "foobar_3",
        definition: "foo plus bar equals foobar 3"
      )

      user_word = UserWord.create!(word: word, user: user)
      user_word_2 = UserWord.create!(word: word_2, user: user)
      user_word_3 = UserWord.create!(word: word_3, user: user)

      game_fundamental = Game.create!(
        name: "Fundamentals",
        description: "Be creative"
      )

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)

      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_8)

      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_8)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_2.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      expect(user.has_incomplete_fundamentals?).to eq(true)
    end
  end

  describe "#has_incomplete_jeopardys?" do
    it "returns false" do
      user = User.create(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password",
        email: ""
      )

      word = Word.create(
        name: "foobar",
        definition: "foo plus bar equals foobar"
      )
      word_2 = Word.create(
        name: "foobar_2",
        definition: "foo plus bar equals foobar 2"
      )
      word_3 = Word.create(
        name: "foobar_3",
        definition: "foo plus bar equals foobar 3"
      )

      user_word = UserWord.create!(word: word, user: user)
      user_word_2 = UserWord.create!(word: word_2, user: user)
      user_word_3 = UserWord.create!(word: word_3, user: user)

      game_fundamental = Game.create!(
        name: "Fundamentals",
        description: "Be creative"
      )

      game_jeopardy = Game.create!(
        name: "Jeopardy",
        description: "Be creative"
      )

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)

      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_28)

      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_28)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_2.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_3.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_2.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_3.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      expect(user.has_incomplete_jeopardys?).to eq(false)
    end

    it "returns true" do
      user = User.create(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password",
        email: ""
      )

      word = Word.create(
        name: "foobar",
        definition: "foo plus bar equals foobar"
      )
      word_2 = Word.create(
        name: "foobar_2",
        definition: "foo plus bar equals foobar 2"
      )
      word_3 = Word.create(
        name: "foobar_3",
        definition: "foo plus bar equals foobar 3"
      )

      user_word = UserWord.create!(word: word, user: user)
      user_word_2 = UserWord.create!(word: word_2, user: user)
      user_word_3 = UserWord.create!(word: word_3, user: user)

      game_fundamental = Game.create!(
        name: "Fundamentals",
        description: "Be creative"
      )

      game_jeopardy = Game.create!(
        name: "Jeopardy",
        description: "Be creative"
      )

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)

      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_28)

      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_28)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_2.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      expect(user.has_incomplete_jeopardys?).to eq(true)
    end
  end

  describe "#has_incomplete_freestyles?" do
    it "returns false" do
      user = User.create(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password",
        email: ""
      )

      word = Word.create(
        name: "foobar",
        definition: "foo plus bar equals foobar"
      )
      word_2 = Word.create(
        name: "foobar_2",
        definition: "foo plus bar equals foobar 2"
      )
      word_3 = Word.create(
        name: "foobar_3",
        definition: "foo plus bar equals foobar 3"
      )

      user_word = UserWord.create!(word: word, user: user)
      user_word_2 = UserWord.create!(word: word_2, user: user)
      user_word_3 = UserWord.create!(word: word_3, user: user)

      game_fundamental = Game.create!(
        name: "Fundamentals",
        description: "Be creative"
      )

      game_jeopardy = Game.create!(
        name: "Jeopardy",
        description: "Be creative"
      )

      game_freestyle = Game.create!(
        name: "Freestyle",
        description: "Be creative"
      )

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )
      level_29 = Level.create!(
        focus: "Freestyle focus 29",
        direction: "Direction"
      )
      level_30 = Level.create!(
        focus: "Freestyle focus 30",
        direction: "Direction"
      )
      level_31 = Level.create!(
        focus: "Freestyle focus 31",
        direction: "Direction"
      )
      level_32 = Level.create!(
        focus: "Freestyle focus 32",
        direction: "Direction"
      )
      level_33 = Level.create!(
        focus: "Freestyle focus 33",
        direction: "Direction"
      )
      level_34 = Level.create!(
        focus: "Freestyle focus 34",
        direction: "Type the word below:"
      )
      level_35 = Level.create!(
        focus: "Freestyle focus 35",
        direction: "Direction"
      )
      level_36 = Level.create!(
        focus: "Freestyle focus 36",
        direction: "Direction"
      )
      level_37 = Level.create!(
        focus: "Freestyle focus 37",
        direction: "Direction"
      )
      level_38 = Level.create!(
        focus: "Freestyle focus 38",
        direction: "Direction"
      )
      level_39 = Level.create!(
        focus: "Freestyle focus 39",
        direction: "Direction"
      )
      level_40 = Level.create!(
        focus: "Freestyle focus 40",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)
      free_gl_29 = GameLevel.create!(game: game_freestyle, level: level_29)
      free_gl_30 = GameLevel.create!(game: game_freestyle, level: level_30)
      free_gl_31 = GameLevel.create!(game: game_freestyle, level: level_31)
      free_gl_32 = GameLevel.create!(game: game_freestyle, level: level_32)
      free_gl_33 = GameLevel.create!(game: game_freestyle, level: level_33)
      free_gl_34 = GameLevel.create!(game: game_freestyle, level: level_34)
      free_gl_35 = GameLevel.create!(game: game_freestyle, level: level_35)
      free_gl_36 = GameLevel.create!(game: game_freestyle, level: level_36)
      free_gl_37 = GameLevel.create!(game: game_freestyle, level: level_37)
      free_gl_38 = GameLevel.create!(game: game_freestyle, level: level_38)
      free_gl_39 = GameLevel.create!(game: game_freestyle, level: level_39)
      free_gl_40 = GameLevel.create!(game: game_freestyle, level: level_40)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_40)

      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_40)

      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_40)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_2.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_3.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_2.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_3.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word.uwgl_freestyles.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_2.uwgl_freestyles.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_3.uwgl_freestyles.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      expect(user.has_incomplete_freestyles?).to eq(false)
    end

    it "returns true" do
      user = User.create(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password",
        email: ""
      )

      word = Word.create(
        name: "foobar",
        definition: "foo plus bar equals foobar"
      )
      word_2 = Word.create(
        name: "foobar_2",
        definition: "foo plus bar equals foobar 2"
      )
      word_3 = Word.create(
        name: "foobar_3",
        definition: "foo plus bar equals foobar 3"
      )

      user_word = UserWord.create!(word: word, user: user)
      user_word_2 = UserWord.create!(word: word_2, user: user)
      user_word_3 = UserWord.create!(word: word_3, user: user)

      game_fundamental = Game.create!(
        name: "Fundamentals",
        description: "Be creative"
      )

      game_jeopardy = Game.create!(
        name: "Jeopardy",
        description: "Be creative"
      )

      game_freestyle = Game.create!(
        name: "Freestyle",
        description: "Be creative"
      )

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )
      level_29 = Level.create!(
        focus: "Freestyle focus 29",
        direction: "Direction"
      )
      level_30 = Level.create!(
        focus: "Freestyle focus 30",
        direction: "Direction"
      )
      level_31 = Level.create!(
        focus: "Freestyle focus 31",
        direction: "Direction"
      )
      level_32 = Level.create!(
        focus: "Freestyle focus 32",
        direction: "Direction"
      )
      level_33 = Level.create!(
        focus: "Freestyle focus 33",
        direction: "Direction"
      )
      level_34 = Level.create!(
        focus: "Freestyle focus 34",
        direction: "Type the word below:"
      )
      level_35 = Level.create!(
        focus: "Freestyle focus 35",
        direction: "Direction"
      )
      level_36 = Level.create!(
        focus: "Freestyle focus 36",
        direction: "Direction"
      )
      level_37 = Level.create!(
        focus: "Freestyle focus 37",
        direction: "Direction"
      )
      level_38 = Level.create!(
        focus: "Freestyle focus 38",
        direction: "Direction"
      )
      level_39 = Level.create!(
        focus: "Freestyle focus 39",
        direction: "Direction"
      )
      level_40 = Level.create!(
        focus: "Freestyle focus 40",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)
      free_gl_29 = GameLevel.create!(game: game_freestyle, level: level_29)
      free_gl_30 = GameLevel.create!(game: game_freestyle, level: level_30)
      free_gl_31 = GameLevel.create!(game: game_freestyle, level: level_31)
      free_gl_32 = GameLevel.create!(game: game_freestyle, level: level_32)
      free_gl_33 = GameLevel.create!(game: game_freestyle, level: level_33)
      free_gl_34 = GameLevel.create!(game: game_freestyle, level: level_34)
      free_gl_35 = GameLevel.create!(game: game_freestyle, level: level_35)
      free_gl_36 = GameLevel.create!(game: game_freestyle, level: level_36)
      free_gl_37 = GameLevel.create!(game: game_freestyle, level: level_37)
      free_gl_38 = GameLevel.create!(game: game_freestyle, level: level_38)
      free_gl_39 = GameLevel.create!(game: game_freestyle, level: level_39)
      free_gl_40 = GameLevel.create!(game: game_freestyle, level: level_40)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_40)

      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_40)

      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_40)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_2.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_3.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_2.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_3.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      expect(user.has_incomplete_freestyles?).to eq(true)
    end
  end

  describe "#has_enough_jeopardy_words?" do
    it "returns false" do
      user = User.create(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password",
        email: ""
      )

      word = Word.create(
        name: "foobar",
        definition: "foo plus bar equals foobar"
      )
      word_2 = Word.create(
        name: "foobar_2",
        definition: "foo plus bar equals foobar 2"
      )
      word_3 = Word.create(
        name: "foobar_3",
        definition: "foo plus bar equals foobar 3"
      )

      user_word = UserWord.create!(word: word, user: user)
      user_word_2 = UserWord.create!(word: word_2, user: user)
      user_word_3 = UserWord.create!(word: word_3, user: user)

      game_fundamental = Game.create!(
        name: "Fundamentals",
        description: "Be creative"
      )

      game_jeopardy = Game.create!(
        name: "Jeopardy",
        description: "Be creative"
      )

      game_freestyle = Game.create!(
        name: "Freestyle",
        description: "Be creative"
      )

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )
      level_29 = Level.create!(
        focus: "Freestyle focus 29",
        direction: "Direction"
      )
      level_30 = Level.create!(
        focus: "Freestyle focus 30",
        direction: "Direction"
      )
      level_31 = Level.create!(
        focus: "Freestyle focus 31",
        direction: "Direction"
      )
      level_32 = Level.create!(
        focus: "Freestyle focus 32",
        direction: "Direction"
      )
      level_33 = Level.create!(
        focus: "Freestyle focus 33",
        direction: "Direction"
      )
      level_34 = Level.create!(
        focus: "Freestyle focus 34",
        direction: "Type the word below:"
      )
      level_35 = Level.create!(
        focus: "Freestyle focus 35",
        direction: "Direction"
      )
      level_36 = Level.create!(
        focus: "Freestyle focus 36",
        direction: "Direction"
      )
      level_37 = Level.create!(
        focus: "Freestyle focus 37",
        direction: "Direction"
      )
      level_38 = Level.create!(
        focus: "Freestyle focus 38",
        direction: "Direction"
      )
      level_39 = Level.create!(
        focus: "Freestyle focus 39",
        direction: "Direction"
      )
      level_40 = Level.create!(
        focus: "Freestyle focus 40",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)
      free_gl_29 = GameLevel.create!(game: game_freestyle, level: level_29)
      free_gl_30 = GameLevel.create!(game: game_freestyle, level: level_30)
      free_gl_31 = GameLevel.create!(game: game_freestyle, level: level_31)
      free_gl_32 = GameLevel.create!(game: game_freestyle, level: level_32)
      free_gl_33 = GameLevel.create!(game: game_freestyle, level: level_33)
      free_gl_34 = GameLevel.create!(game: game_freestyle, level: level_34)
      free_gl_35 = GameLevel.create!(game: game_freestyle, level: level_35)
      free_gl_36 = GameLevel.create!(game: game_freestyle, level: level_36)
      free_gl_37 = GameLevel.create!(game: game_freestyle, level: level_37)
      free_gl_38 = GameLevel.create!(game: game_freestyle, level: level_38)
      free_gl_39 = GameLevel.create!(game: game_freestyle, level: level_39)
      free_gl_40 = GameLevel.create!(game: game_freestyle, level: level_40)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word, game_level: free_gl_40)

      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: free_gl_40)

      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_28)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_29)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_30)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_31)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_32)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_33)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_34)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_35)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_36)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_37)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_38)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_39)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: free_gl_40)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_2.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_3.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_2.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_3.uwgl_jeopardys.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      expect(user.has_enough_jeopardy_words?).to eq(false)
    end

    it "returns true" do
      user = User.create(
        username: "fizzBuzzzzed",
        password: "password",
        password_confirmation: "password",
        email: ""
      )

      word = Word.create(
        name: "foobar",
        definition: "foo plus bar equals foobar"
      )
      word_2 = Word.create(
        name: "foobar_2",
        definition: "foo plus bar equals foobar 2"
      )
      word_3 = Word.create(
        name: "foobar_3",
        definition: "foo plus bar equals foobar 3"
      )
      word_4 = Word.create(
        name: "foobar_4",
        definition: "foo plus bar equals foobar 4"
      )

      user_word = UserWord.create!(word: word, user: user)
      user_word_2 = UserWord.create!(word: word_2, user: user)
      user_word_3 = UserWord.create!(word: word_3, user: user)
      user_word_4 = UserWord.create!(word: word_4, user: user)

      game_fundamental = Game.create!(
        name: "Fundamentals",
        description: "Be creative"
      )

      game_jeopardy = Game.create!(
        name: "Jeopardy",
        description: "Be creative"
      )

      level_1 = Level.create!(
        focus: "Fundamentals focus 1",
        direction: "Type the word below:"
      )
      level_2 = Level.create!(
        focus: "Fundamentals focus 2",
        direction: "Direction"
      )
      level_3 = Level.create!(
        focus: "Fundamentals focus 3",
        direction: "Direction"
      )
      level_4 = Level.create!(
        focus: "Fundamentals focus 4",
        direction: "Direction"
      )
      level_5 = Level.create!(
        focus: "Fundamentals focus 5",
        direction: "Direction"
      )
      level_6 = Level.create!(
        focus: "Fundamentals focus 6",
        direction: "Direction"
      )
      level_7 = Level.create!(
        focus: "Fundamentals focus 7",
        direction: "Direction"
      )
      level_8 = Level.create!(
        focus: "Fundamentals focus 8",
        direction: "Direction"
      )
      level_9 = Level.create!(
        focus: "Jeopardy focus 9",
        direction: "Type the word below:"
      )
      level_10 = Level.create!(
        focus: "Jeopardy focus 10",
        direction: "Direction"
      )
      level_11 = Level.create!(
        focus: "Jeopardy focus 11",
        direction: "Direction"
      )
      level_12 = Level.create!(
        focus: "Jeopardy focus 12",
        direction: "Direction"
      )
      level_13 = Level.create!(
        focus: "Jeopardy focus 13",
        direction: "Direction"
      )
      level_14 = Level.create!(
        focus: "Jeopardy focus 14",
        direction: "Direction"
      )
      level_15 = Level.create!(
        focus: "Jeopardy focus 15",
        direction: "Direction"
      )
      level_16 = Level.create!(
        focus: "Jeopardy focus 16",
        direction: "Direction"
      )
      level_17 = Level.create!(
        focus: "Jeopardy focus 17",
        direction: "Direction"
      )
      level_18 = Level.create!(
        focus: "Jeopardy focus 18",
        direction: "Direction"
      )
      level_19 = Level.create!(
        focus: "Jeopardy focus 19",
        direction: "Direction"
      )
      level_20 = Level.create!(
        focus: "Jeopardy focus 20",
        direction: "Direction"
      )
      level_21 = Level.create!(
        focus: "Jeopardy focus 21",
        direction: "Type the word below:"
      )
      level_22 = Level.create!(
        focus: "Jeopardy focus 22",
        direction: "Direction"
      )
      level_23 = Level.create!(
        focus: "Jeopardy focus 23",
        direction: "Direction"
      )
      level_24 = Level.create!(
        focus: "Jeopardy focus 24",
        direction: "Direction"
      )
      level_25 = Level.create!(
        focus: "Jeopardy focus 25",
        direction: "Direction"
      )
      level_26 = Level.create!(
        focus: "Jeopardy focus 26",
        direction: "Direction"
      )
      level_27 = Level.create!(
        focus: "Jeopardy focus 27",
        direction: "Direction"
      )
      level_28 = Level.create!(
        focus: "Jeopardy focus 28",
        direction: "Direction"
      )

      fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
      fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
      fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
      fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
      fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
      fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
      fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
      fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
      jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
      jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
      jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
      jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
      jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
      jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
      jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
      jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
      jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
      jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
      jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
      jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
      jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
      jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
      jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
      jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
      jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
      jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
      jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
      jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)

      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)

      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_2, game_level: jeop_gl_28)

      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_3, game_level: jeop_gl_28)

      UserWordGameLevel.create!(user_word: user_word_4, game_level: fund_gl_1)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: fund_gl_2)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: fund_gl_3)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: fund_gl_4)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: fund_gl_5)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: fund_gl_6)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: fund_gl_7)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: fund_gl_8)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_9)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_10)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_11)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_12)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_13)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_14)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_15)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_16)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_17)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_18)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_19)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_20)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_21)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_22)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_23)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_24)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_25)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_26)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_27)
      UserWordGameLevel.create!(user_word: user_word_4, game_level: jeop_gl_28)

      user_word.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_2.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_3.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      user_word_4.uwgl_fundamentals.each do |uwgl|
        uwgl.status = "complete"
        uwgl.save
      end

      expect(user.has_enough_jeopardy_words?).to eq(true)
    end
  end

end
