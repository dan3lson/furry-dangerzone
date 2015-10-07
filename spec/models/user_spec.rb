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
end
