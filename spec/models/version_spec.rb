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

  describe "#has_reviews?" do
    it "returns false" do
      expect(version.has_reviews?).to eq(false)
    end
    it "returns true" do
      version.reviews << review
      expect(version.has_reviews?).to eq(true)
    end
  end

  describe "#number_of_reviews" do
    it "returns a count integer" do
      version.reviews << review
      expect(version.reviews.count).to eq(1)
    end
  end

  describe "#review_ratings" do
    it "returns an array of ratings" do
      version.reviews << review
      version.reviews << FactoryGirl.create(:review, rating: 3)
      version.reviews << FactoryGirl.create(:review, rating: 4)
      expect(version.review_ratings.count).to eq(3)
      expect(version.review_ratings.reduce(:+)).to eq(12)
    end
  end

  describe "#average_rating" do
    it "returns an integer" do
      version.reviews << review
      version.reviews << FactoryGirl.create(:review, rating: 3)
      version.reviews << FactoryGirl.create(:review, rating: 4)
      expect(version.average_rating).to eq(4)
    end
  end

  describe "#total_number_of_reviews" do
    it "returns an integer" do
      version.reviews << review
      version.reviews << FactoryGirl.create(:review, rating: 3)
      version.reviews << FactoryGirl.create(:review, rating: 4)
      expect(Version.total_number_of_reviews).to eq(3)
    end
  end

  describe "#total_average_rating" do
    it "returns an integer" do
      version.reviews << review
      version.reviews << FactoryGirl.create(:review, rating: 3)
      version.reviews << FactoryGirl.create(:review, rating: 4)
      expect(Version.total_average_rating).to eq(4)
    end
  end
end
