require 'rails_helper'

RSpec.describe Version, type: :model do
  let(:version) { FactoryGirl.create(:version) }
  let(:review) { FactoryGirl.create(:review) }

  describe "associatons" do
    it { should have_many(:reviews) }
  end

  describe "validations" do
    it { should validate_presence_of(:description) }
    subject { Version.new(description: "description") }
    it { should validate_presence_of(:number) }
    it { should validate_uniqueness_of(:number) }
  end

  describe "#initialization" do
    it "returns number string" do
      expect(version.number).to include("1.0.")
    end
    it "returns description text" do
      expect(version.description).to eq("Awesome new feature")
    end
  end

  def version_name
    it "returns full number string" do
      expect(version.full_name).to include("Version 1.0.")
    end
  end

  describe "#has_reviews?" do
    it "returns false" do
      expect(version.has_reviews?).to eq(false)
    end
    it "returns true" do
      version.reviews << review
      expect(version.has_reviews?).to eq(true)
    end
  end
end
