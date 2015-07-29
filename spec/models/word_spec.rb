require 'rails_helper'

RSpec.describe Word, type: :model do
  let!(:word) { FactoryGirl.create(:word) }

  describe "associatons" do
    it { should have_many(:user_words) }
    it { should have_many(:users) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:definition) }
    subject {
      Word.new(
        part_of_speech: "part_of_speech",
        phonetic_spelling: "phonetic_spelling",
        definition: "definition",
        example_sentence: "example_sentence"
      )
    }
    it { should validate_uniqueness_of(:name) }
  end

  describe "#initialization" do
    it "returns a word name" do
      expect(word.name).to eq("chess")
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
    it "returns a word example sentence" do
      expect(word.example_sentence).to eq("Do you play chess?")
    end
  end

  describe "#define" do
    it "returns Word object" do
      expect(Word.define(word.name).first.class).to be(Word)
    end
  end

  describe "#has_records" do
    it "returns true if more than one record exists" do
      expect(Word.has_records?).to eq(true)
    end
    it "returns false if zero records exists" do
      word.destroy
      expect(Word.has_records?).to eq(false)
    end
  end

  describe "#random" do
    it "returns a random word" do
      expect(Word.random.class).to be(String)
    end
  end
end
