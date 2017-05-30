require 'rails_helper'

RSpec.describe Word, type: :model do
  let!(:word) { FactoryGirl.create(:word) }
  let(:word_2) { FactoryGirl.create(:word) }
  let(:word_3) { FactoryGirl.create(:word) }

  skip "associatons" do
    it { should have_many(:user_words) }
    it { should have_many(:users) }
  end

  skip "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:definition) }
  end

  describe "#initialization" do
    it "returns a word name" do
      expect(word.name).to eq("chess 1")
    end
    it "returns a word phonetic_spelling" do
      expect(word.phonetic_spelling).to eq("/tʃes/")
    end
    it "returns a word part_of_speech" do
      expect(word.part_of_speech).to eq("noun")
    end
    it "returns a word definition" do
      expect(word.definition).to eq("a game for two people, played on a board")
    end
  end

  describe "::define" do
    it "returns Word object" do
      expect(Word.define(word.name).first.class).to be(Word)
    end
  end

  describe "::random" do
    it "returns a random Word object" do
      expect(Word.random(1).first.class).to be(Word)
    end
  end
end
