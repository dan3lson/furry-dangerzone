require 'rails_helper'

RSpec.describe FreeDictionary, type: :model do
  describe "self.define" do
    it "returns a FreeDictionary object" do
      classes = FreeDictionary.define("excited").map { |fd| fd.class }

      expect(classes.first).to eq(FreeDictionary)
    end

    it "returns nil" do
      expect(FreeDictionary.define("foobar_2")).to eq(nil)
    end
  end

  describe "#self.update_part_of_speech" do
    it "returns a noun string" do
      string = "n."

      expect(FreeDictionary.update_part_of_speech(string)).to eq("noun")
    end

    it "returns an adjective string" do
      string = "adj."

      expect(FreeDictionary.update_part_of_speech(string)).to eq("adjective")
    end

    it "returns a verb string" do
      string = "v."

      expect(FreeDictionary.update_part_of_speech(string)).to eq("verb")
    end

    it "returns an verb string" do
      string = "tr.v"

      expect(FreeDictionary.update_part_of_speech(string)).to eq("verb")
    end

    it "returns an adverb string" do
      string = "adv."

      expect(FreeDictionary.update_part_of_speech(string)).to eq("adverb")
    end
  end

  describe "#self.remove_ordered_list" do
    it "returns a string without ordered list presence" do
      string = "1. a.  focus.b.  To bring into one main body***2.  To make ..."

      expect(FreeDictionary.remove_ordered_list(string)).to eq(
        " a.  focus.b.  To bring into one main body***  To make ..."
      )
    end
  end

  describe "#self.keep_one_phonetic_spelling" do
    it "returns a string with one phonetic_spelling" do
      string = "vo•cab•u•lar•y1vo•cab•u•lar•y2"

      expect(FreeDictionary.keep_one_phonetic_spelling(string)).to eq(
        "vo•cab•u•lar•y"
      )
    end
  end

  describe "#self.string_has_digits" do
    it "returns true" do
      string = "vo•cab•u•lar•y1"

      expect(FreeDictionary.string_has_digits?(string)).to eq(true)
    end

    it "returns false" do
      string = "vo•cab•u•lar•y"

      expect(FreeDictionary.string_has_digits?(string)).to eq(false)
    end
  end

  describe "#self.string_in_parens" do
    it "returns true" do
      string = "vocabulary is (awesome)."

      expect(FreeDictionary.string_in_parens?(string)).to eq(true)
    end

    it "returns false" do
      string = "vocabulary"

      expect(FreeDictionary.string_in_parens?(string)).to eq(false)
    end
  end

  describe "#self.remove_string_in_parens" do
    it "returns string without parens and string in parens" do
      string = "vocabulary is dope (and awesome)."

      expect(FreeDictionary.remove_string_in_parens(string)).to eq(
        "vocabulary is dope"
      )
    end
  end

  describe "#self.strip_def_of_ex_sents" do
    it "returns string example_sentences in them" do
      definition = "one\'s vocabulary: dictionary"
      example_sentence = "dictionary"

      expect(FreeDictionary.strip_def_of_ex_sents(
          definition, example_sentence
        )
      ).to eq("one\'s vocabulary ")
    end
  end

  describe "#self.open_page" do
    it "returns 404 string" do
      url = "http://www.thefreedictionary.com"
      word = "foobar2"

      expect(FreeDictionary.open_page(url, word)).to eq("404")
    end

    it "returns a Nokogiri object" do
      url = "http://www.thefreedictionary.com"
      word = "chess"

      expect(FreeDictionary.open_page(url, word).class).to eq(
        Nokogiri::HTML::Document
      )
    end
  end
end
