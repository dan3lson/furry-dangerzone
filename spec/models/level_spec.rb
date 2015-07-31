require 'rails_helper'

RSpec.describe Level, type: :model do
  let!(:level) { FactoryGirl.create(:level) }

  describe "associatons" do
    it { should have_many(:game_levels) }
    it { should have_many(:games) }
  end

  describe "validations" do
    it { should validate_presence_of(:focus) }
    it { should validate_presence_of(:direction) }
  end

  describe "#initialization" do
    it "returns a level focus" do
      expect(level.focus).to eq("Spelling")
    end
    it "returns a level direction" do
      expect(level.direction).to eq("Type the word below:")
    end
  end
end
