require 'rails_helper'

RSpec.describe UserSource, type: :model do
  let(:user_source) { FactoryGirl.create(:user_source) }

  describe "associatons" do
    it { should belong_to(:user) }
    it { should belong_to(:source) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:source) }
  end

  describe "#initialization" do
    it "returns User and Source class types" do
      expect(user_source.user.class).to be(User)
      expect(user_source.source.class).to be(Source)
    end
  end
end
