require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryGirl.create(:comment) }

  pending "associatons" do
    it { should belong_to(:blog_post) }
  end

  pending "validations" do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:blog_post) }
  end

  describe "#initialization" do
    it "returns a description" do
      expect(comment.description).to eq("Wow, so clever. I really like it!")
    end

		it "returns Blog class type" do
			expect(comment.blog_post.class).to be(BlogPost)
		end

    it "returns nil for blank User" do
      expect(comment.user).to eq(nil)
    end

    it "returns User class type" do
      user = FactoryGirl.create(:user)
      comment.user = user

      expect(comment.user.class).to eq(User)
    end
  end
end
