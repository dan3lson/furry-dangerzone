require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:word) { FactoryGirl.create(:word) }

  describe "associatons" do
    it { should have_many(:user_words) }
    it { should have_many(:words) }
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

  describe "#has_sources?" do
    it "returns false" do
      expect(user.has_sources?).to eq(false)
    end
    it "returns true" do
      user.sources << source
      expect(user.has_sources?).to eq(true)
    end
  end
end
