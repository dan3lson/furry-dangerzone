require 'rails_helper'

RSpec.describe Word, type: :model do
  let(:word) { FactoryGirl.create(:word) }

  describe "associatons" do
    it { should have_many(:user_words) }
    it { should have_many(:users) }
  end

  describe "validations" do
    it { should validate_presence_of(:part_of_speech) }
    it { should validate_presence_of(:definition) }
    it { should validate_presence_of(:pronunciation) }
    it { should validate_presence_of(:name) }
    subject {
      Word.new(
        part_of_speech: "part_of_speech",
        pronunciation: "pronunciation",
        definition: "definition"
      )
    }
    it { should validate_uniqueness_of(:name) }
  end

  describe "#initialization" do
    it "returns a word name" do
      expect(word.name).to include("foobar")
    end
    it "returns a word pronunciation" do
      expect(word.pronunciation).to eq("foo-bar")
    end
    it "returns a word part_of_speech" do
      expect(word.part_of_speech).to eq("noun")
    end
    it "returns a word definition" do
      expect(word.definition).to eq("lorem ipsum")
    end
  end
end
