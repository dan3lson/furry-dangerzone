require 'rails_helper'

RSpec.describe Feedback, type: :model do
  let!(:feedback) { FactoryGirl.create(:feedback) }

  describe "associatons" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:kind) }
    it { should validate_presence_of(:user) }
  end

  describe "#initialization" do
    it "returns a description" do
      expect(feedback.description).to eq("Leksi could be a little faster.")
    end

    it "returns the kind of feedback, i.e. either bug or wish" do
      expect(feedback.kind).to eq("wish")
    end

		it "returns User class type" do
			expect(feedback.user.class).to be(User)
		end
  end
end
