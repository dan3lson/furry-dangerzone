require 'rails_helper'

RSpec.describe BlogPost, type: :model do
  let(:blog_post) { FactoryGirl.create(:blog_post) }

  describe "associatons" do
    xit { should have_many(:comments) }
  end

  describe "validations" do
    xit { should validate_presence_of(:title) }
    xit { should validate_presence_of(:content) }
    xit { should validate_presence_of(:icon) }
    xit { should validate_presence_of(:slug) }

  end

  describe "#initialization" do
    it "returns a title" do
      expect(blog_post.title).to eq("All About Leksi Part 1")
    end

    it "returns content" do
      expect(blog_post.content).to eq("Blog content for post numero uno.")
    end

    it "returns icon" do
      expect(blog_post.icon).to eq("gamepad")
    end

    it "returns slug" do
      expect(blog_post.slug).to eq("all_about_leksi_part_1")
    end
  end
end
