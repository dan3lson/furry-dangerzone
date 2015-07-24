require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  let(:word) { FactoryGirl.create(:word) }
  let!(:tag) { FactoryGirl.create(:tag) }

  describe "associatons" do
    it { should have_many(:user_words) }
    it { should have_many(:words) }
    it { should have_many(:user_tags) }
    it { should have_many(:tags) }
  end

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_length_of(:username).is_at_least(3) }
    it { should validate_length_of(:username).is_at_most(33) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
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

  describe "#has_tags?" do
    it "returns false" do
      expect(user.has_tags?).to eq(false)
    end
    it "returns true" do
      user.tags << tag
      expect(user.has_tags?).to eq(true)
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

  describe "#already_has_word?" do
    it "returns false" do
      expect(user.already_has_word?(word)).to eq(false)
    end
    it "returns true" do
      user.words << word
      expect(user.already_has_word?(word)).to eq(true)
    end
  end
end
