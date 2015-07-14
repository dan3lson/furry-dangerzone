require 'rails_helper'

RSpec.describe WordSource, type: :model do
  let(:word_source) { FactoryGirl.create(:word_source) }

  describe "associatons" do
    it { should belong_to(:source) }
    it { should belong_to(:word) }
  end

  describe "validations" do
    it { should validate_presence_of(:source) }
    it { should validate_presence_of(:word) }
  end

  describe "#initialization" do
    it "returns User and Word class types" do
      expect(word_source.source.class).to be(Source)
      expect(word_source.word.class).to be(Word)
    end
  end
end
