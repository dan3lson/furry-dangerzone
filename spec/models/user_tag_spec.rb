require 'rails_helper'

RSpec.describe UserTag, type: :model do
  let(:user_tag) { FactoryGirl.create(:user_tag) }

  describe "associatons" do
    it { should belong_to(:user) }
    it { should belong_to(:tag) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:tag) }
  end

  describe "#initialization" do
    it "returns User and Tag class types" do
      expect(user_tag.user.class).to be(User)
      expect(user_tag.tag.class).to be(Tag)
    end
  end
end
