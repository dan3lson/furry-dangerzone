require 'rails_helper'

RSpec.describe WordsHelper, type: :helper do

  describe "#word_has_attribute_value?" do
    let(:word) { FactoryGirl.create(:word) }

    it "returns true (for name)" do
      expect(word_has_attribute_value?(word.name)).to eq(true)
    end

    it "returns true (for phonetic_spelling)" do
      expect(word_has_attribute_value?(word.phonetic_spelling)).to eq(true)
    end

    it "returns true (for part_of_speech)" do
      expect(word_has_attribute_value?(word.part_of_speech)).to eq(true)
    end

    it "returns true (for definition)" do
      expect(word_has_attribute_value?(word.definition)).to eq(true)
    end

    it "returns true (for example_sentence)" do
      expect(word_has_attribute_value?(word.example_sentence)).to eq(true)
    end

    it "returns true (for synonyms)" do
      word.synonyms << FactoryGirl.create(:word, name: "chess_2")

      expect(word_has_attribute_value?(word.synonyms)).to eq(true)
    end

    it "returns true (for antonyms)" do
      word.antonyms << FactoryGirl.create(:word, name: "chess_2")

      expect(word_has_attribute_value?(word.antonyms)).to eq(true)
    end

    it "returns false (for name)" do
      word.name = ""

      expect(word_has_attribute_value?(word.name)).to eq(false)
    end

    it "returns false (for phonetic_spelling)" do
      word.phonetic_spelling = ""

      expect(word_has_attribute_value?(word.phonetic_spelling)).to eq(false)
    end

    it "returns false (for part_of_speech)" do
      word.part_of_speech = ""

      expect(word_has_attribute_value?(word.part_of_speech)).to eq(false)
    end

    it "returns false (for definition)" do
      word.definition = ""

      expect(word_has_attribute_value?(word.definition)).to eq(false)
    end

    it "returns false (for example_sentence)" do
      word.example_sentence = ""

      expect(word_has_attribute_value?(word.example_sentence)).to eq(false)
    end

    it "returns false (for synonyms)" do
      expect(word_has_attribute_value?(word.synonyms)).to eq(false)
    end

    it "returns false (for antonyms)" do
      expect(word_has_attribute_value?(word.antonyms)).to eq(false)
    end
  end

  describe "#attribute_is_example_sentence_or_definition?" do
    it "returns true (for example_sentence)" do
      expect(attribute_is_example_sentence_or_definition?("example_sentence")).to eq(true)
    end

    it "returns false (for example_sentence)" do
      expect(attribute_is_example_sentence_or_definition?("")).to eq(false)
    end

    it "returns true (for definition)" do
      expect(attribute_is_example_sentence_or_definition?("definition")).to eq(true)
    end

    it "returns false (for definition)" do
      expect(attribute_is_example_sentence_or_definition?("")).to eq(false)
    end

    it "returns false (for any string)" do
      expect(attribute_is_example_sentence_or_definition?("any string")).to eq(false)
    end

    it "returns false (for blank)" do
      expect(attribute_is_example_sentence_or_definition?("")).to eq(false)
    end
  end

  describe "#attribute_is_synonym_or_antonym?" do
    it "returns true (for synonyms)" do
      expect(attribute_is_synonym_or_antonym?("synonyms")).to eq(true)
    end

    it "returns false (for synonyms)" do
      expect(attribute_is_synonym_or_antonym?("")).to eq(false)
    end

    it "returns true (for antonyms)" do
      expect(attribute_is_synonym_or_antonym?("antonyms")).to eq(true)
    end

    it "returns false (for antonyms)" do
      expect(attribute_is_synonym_or_antonym?("")).to eq(false)
    end

    it "returns false (for any string)" do
      expect(attribute_is_synonym_or_antonym?("any string")).to eq(false)
    end

    it "returns false (for blank)" do
      expect(attribute_is_synonym_or_antonym?("")).to eq(false)
    end
  end
end
