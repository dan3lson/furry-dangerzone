require 'rails_helper'

RSpec.describe Blog, type: :model do
  let!(:blog) { FactoryGirl.create(:blog) }

  describe "associatons" do
    it { should have_many(:comments) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
  end

  describe "#initialization" do
    it "returns a title" do
      expect(blog.title).to eq("All About Leksi Part 1")
    end
  end
end
