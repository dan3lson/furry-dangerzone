require 'rails_helper'

RSpec.describe Source, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:source) { FactoryGirl.create(:source) }

  describe "associatons" do
    it { should have_many(:user_sources) }
    it { should have_many(:users) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "#initialization" do
    it "returns a source name" do
      expect(source.name).to include("foo_source")
    end
  end
end
