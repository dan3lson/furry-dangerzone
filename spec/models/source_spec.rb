require 'rails_helper'

RSpec.describe Source, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:source) { FactoryGirl.create(:source) }

  describe "associatons" do
    xit { should have_many(:user_sources) }
    xit { should have_many(:users) }
    xit { should have_many(:words) }
    xit { should have_many(:word_sources) }
  end

  describe "validations" do
    xit { should validate_presence_of(:name) }
    xit { should validate_uniqueness_of(:name) }
  end

  describe "#initialization" do
    xit "returns a source name" do
      expect(source.name).to include("foo_source")
    end
  end
end
