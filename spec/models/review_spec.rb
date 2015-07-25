require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:review) { FactoryGirl.create(:review) }

  describe "associatons" do
    it { should belong_to(:user) }
    it { should belong_to(:version) }
  end

  describe "validations" do
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:version) }
  end

  describe "#initialization" do
    it "returns rating integer" do
      expect(review.rating).to eq(5)
    end
    it "returns description text" do
      expect(review.description).to eq("this app is dope and pretty useful!")
    end
    it "returns User and Version class types" do
      expect(review.user.class).to be(User)
      expect(review.version.class).to be(Version)
    end
  end
end
