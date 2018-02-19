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

  describe "#is_brainiac?" do
    it "returns false" do
      expect(user.is_brainiac?).to eq(false)
    end

    it "returns true" do
      user.type = "Brainiac"

      expect(user.is_brainiac?).to eq(true)
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
end
