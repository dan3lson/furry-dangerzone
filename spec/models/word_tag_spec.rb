require 'rails_helper'

RSpec.describe WordTag, type: :model do
  let(:word_tag) { FactoryGirl.create(:word_tag) }

  describe "associatons" do
    it { should belong_to(:tag) }
    it { should belong_to(:word) }
  end

  describe "validations" do
    it { should validate_presence_of(:tag) }
    it { should validate_presence_of(:word) }
  end

  describe "#initialization" do
    it "returns User and Word class types" do
      expect(word_tag.tag.class).to be(Tag)
      expect(word_tag.word.class).to be(Word)
    end
  end
end
