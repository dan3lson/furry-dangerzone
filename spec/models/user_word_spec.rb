require 'rails_helper'

RSpec.describe UserWord, type: :model do
  let(:user_word) { FactoryGirl.create(:user_word) }

  describe "associatons" do
    it { should belong_to(:user) }
    it { should belong_to(:word) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:word) }
  end

  describe "#initialization" do
    it "returns User and Word class types" do
      expect(user_word.user.class).to be(User)
      expect(user_word.word.class).to be(Word)
    end
  end
end
