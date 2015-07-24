require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:tag) { FactoryGirl.create(:tag) }

  describe "associatons" do
    it { should have_many(:user_tags) }
    it { should have_many(:users) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "#initialization" do
    it "returns a tag name" do
      expect(tag.name).to include("foo_tag")
    end
  end
end
