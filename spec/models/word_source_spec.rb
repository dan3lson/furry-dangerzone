require 'rails_helper'

RSpec.describe WordSource, type: :model do
  let(:word_source) { FactoryGirl.create(:word_source) }

  describe "associatons" do
    xit { should belong_to(:source) }
    xit { should belong_to(:word) }
  end

  describe "validations" do
    xit { should validate_presence_of(:sourec) }
    xit { should validate_presence_of(:word) }
  end

  describe "#initialization" do
    xit "returns User and Word class types" do
      expect(word_source.user.class).to be(Source)
      expect(word_source.word.class).to be(Word)
    end
  end
end
