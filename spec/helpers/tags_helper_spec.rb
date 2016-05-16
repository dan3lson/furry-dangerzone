require 'rails_helper'

RSpec.describe TagsHelper, type: :helper do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_2) { FactoryGirl.create(:user) }
  let(:word) { FactoryGirl.create(:word) }
  let(:word_2) { FactoryGirl.create(:word, name: "chess_2") }
  let(:word_3) { FactoryGirl.create(:word, definition: "best strategy game!") }
  let(:tag) { FactoryGirl.create(:tag, name: "tag_1") }
  let(:tag_2) { FactoryGirl.create(:tag, name: "tag_2") }
  let(:tag_3) { FactoryGirl.create(:tag, name: "tag_3") }

  describe "#tags_for(user, word)" do
    it "returns 1 Tag -> only one user" do
      UserWord.create!(user: user, word: word)
      UserTag.create!(user: user, tag: tag)
      wt = WordTag.create!(word: word, tag: tag)
      UserWordTag.create!(user: user, word_tag: wt)

      expect(tags_for(user, word).count).to eq(1)
      expect(tags_for(user, word).first.name).to eq("tag_1")
    end

    it "returns 3 Tags -> one user, one word multiple tags" do
      UserWord.create!(user: user, word: word)

      UserTag.create!(user: user, tag: tag)
      UserTag.create!(user: user, tag: tag_2)
      UserTag.create!(user: user, tag: tag_3)

      wt = WordTag.create!(word: word, tag: tag)
      wt_2 = WordTag.create!(word: word, tag: tag_2)
      wt_3 = WordTag.create!(word: word, tag: tag_3)

      UserWordTag.create!(user: user, word_tag: wt)
      UserWordTag.create!(user: user, word_tag: wt_2)
      UserWordTag.create!(user: user, word_tag: wt_3)

      tag_names = tags_for(user, word).map { |t| t.name }

      expect(tags_for(user, word).count).to eq(3)
      expect(tag_names.include?("tag_1")).to eq(true)
      expect(tag_names.include?("tag_2")).to eq(true)
      expect(tag_names.include?("tag_3")).to eq(true)
    end

    it "returns 2 Tags -> two users, two words, multiple tags" do
      UserWord.create!(user: user, word: word)
      UserWord.create!(user: user_2, word: word)
      UserWord.create!(user: user_2, word: word_2)

      UserTag.create!(user: user, tag: tag)
      UserTag.create!(user: user, tag: tag_2)
      UserTag.create!(user: user, tag: tag_3)
      UserTag.create!(user: user_2, tag: tag)
      UserTag.create!(user: user_2, tag: tag_3)

      wt = WordTag.create!(word: word, tag: tag)
      wt_2 = WordTag.create!(word: word, tag: tag_2)
      wt_3 = WordTag.create!(word: word, tag: tag_3)
      wt_4 = WordTag.create!(word: word_2, tag: tag)
      wt_5 = WordTag.create!(word: word_2, tag: tag_3)

      UserWordTag.create!(user: user, word_tag: wt)
      UserWordTag.create!(user: user, word_tag: wt_2)
      UserWordTag.create!(user: user, word_tag: wt_3)
      UserWordTag.create!(user: user_2, word_tag: wt)
      UserWordTag.create!(user: user_2, word_tag: wt_3)
      UserWordTag.create!(user: user_2, word_tag: wt_4)
      UserWordTag.create!(user: user_2, word_tag: wt_5)

      expect(tags_for(user, word).count).to eq(3)
      expect(tags_for(user, word_2).count).to eq(0)

      tag_names = tags_for(user_2, word).map { |t| t.name }
      tag_names_2 = tags_for(user_2, word_2).map { |t| t.name }

      expect(tags_for(user_2, word).count).to eq(2)
      expect(tag_names.include?("tag_1")).to eq(true)
      expect(tag_names.include?("tag_2")).to eq(false)
      expect(tag_names.include?("tag_3")).to eq(true)
      expect(tags_for(user_2, word_2).count).to eq(2)
      expect(tag_names_2.include?("tag_1")).to eq(true)
      expect(tag_names_2.include?("tag_2")).to eq(false)
      expect(tag_names_2.include?("tag_3")).to eq(true)
    end

    it "returns 2 Tags -> one user, one tag, same word name/diff defs" do
      UserWord.create!(user: user, word: word)
      UserWord.create!(user: user, word: word_3)

      UserTag.create!(user: user, tag: tag)

      wt = WordTag.create!(word: word, tag: tag)
      wt_2 = WordTag.create!(word: word_3, tag: tag)

      UserWordTag.create!(user: user, word_tag: wt)
      UserWordTag.create!(user: user, word_tag: wt_2)

      tag_names = tags_for(user, word_3).map { |t| t.name }

      expect(tags_for(user, word).count).to eq(1)
      expect(tags_for(user, word_3).count).to eq(1)
      expect(tag_names.include?("tag_1")).to eq(true)
    end

    it "returns 1 Tags -> two users, one word, multiple tags" do
      UserWord.create!(user: user, word: word)
      UserWord.create!(user: user_2, word: word)

      UserTag.create!(user: user, tag: tag)
      UserTag.create!(user: user, tag: tag_2)
      UserTag.create!(user: user_2, tag: tag_2)

      wt = WordTag.create!(word: word, tag: tag)
      wt_2 = WordTag.create!(word: word, tag: tag_2)

      UserWordTag.create!(user: user, word_tag: wt)
      UserWordTag.create!(user: user_2, word_tag: wt_2)

      tag_names = tags_for(user, word).map { |t| t.name }

      expect(tags_for(user, word).count).to eq(1)
      expect(tag_names.include?("tag_1")).to eq(true)
      expect(tag_names.include?("tag_2")).to eq(false)

      tag_names_2 = tags_for(user_2, word).map { |t| t.name }

      expect(tags_for(user_2, word).count).to eq(1)
      expect(tag_names_2.include?("tag_1")).to eq(false)
      expect(tag_names_2.include?("tag_2")).to eq(true)
    end

    it "returns 1 Tags -> two users, one word, same tag" do
      UserWord.create!(user: user, word: word)
      UserWord.create!(user: user_2, word: word)

      UserTag.create!(user: user, tag: tag)
      UserTag.create!(user: user_2, tag: tag)

      wt = WordTag.create!(word: word, tag: tag)

      UserWordTag.create!(user: user, word_tag: wt)
      UserWordTag.create!(user: user_2, word_tag: wt)

      tag_names = tags_for(user, word).map { |t| t.name }

      expect(tags_for(user, word).count).to eq(1)
      expect(tag_names.include?("tag_1")).to eq(true)

      tag_names_2 = tags_for(user_2, word).map { |t| t.name }

      expect(tags_for(user_2, word).count).to eq(1)
      expect(tag_names_2.include?("tag_1")).to eq(true)
    end
  end

  describe "#tags_exist?(user, word)" do
    it "returns true" do
      UserWord.create!(user: user, word: word)
      UserWord.create!(user: user, word: word_3)

      UserTag.create!(user: user, tag: tag)

      wt = WordTag.create!(word: word, tag: tag)
      wt_2 = WordTag.create!(word: word_3, tag: tag)

      UserWordTag.create!(user: user, word_tag: wt)
      UserWordTag.create!(user: user, word_tag: wt_2)

      expect(tags_exist?(user, word)).to eq(true)
    end

    it "returns false" do
      UserWord.create!(user: user, word: word)
      UserWord.create!(user: user, word: word_3)

      UserTag.create!(user: user, tag: tag)

      expect(tags_exist?(user, word)).to eq(false)
    end
  end

  describe "#unused_tags?(user, word)" do
    it "returns 0 unused tags -> one user" do
      UserWord.create!(user: user, word: word)
      UserWord.create!(user: user, word: word_2)

      UserTag.create!(user: user, tag: tag)
      UserTag.create!(user: user, tag: tag_2)

      expect(unused_tags(user, word).count).to eq(2)
      expect(unused_tags(user, word_2).count).to eq(2)
    end

    it "returns 1 unused tag -> one user" do
      UserWord.create!(user: user, word: word)
      UserWord.create!(user: user, word: word_2)

      UserTag.create!(user: user, tag: tag)
      UserTag.create!(user: user, tag: tag_2)

      wt = WordTag.create!(word: word, tag: tag)
      wt_2 = WordTag.create!(word: word_2, tag: tag)

      UserWordTag.create!(user: user, word_tag: wt)
      UserWordTag.create!(user: user, word_tag: wt_2)

      expect(unused_tags(user, word).count).to eq(1)
    end

    it "returns 1 unused tag -> two users" do
      UserWord.create!(user: user, word: word)
      UserWord.create!(user: user_2, word: word)

      UserTag.create!(user: user, tag: tag)
      UserTag.create!(user: user_2, tag: tag)

      wt = WordTag.create!(word: word, tag: tag)

      UserWordTag.create!(user: user, word_tag: wt)

      expect(unused_tags(user_2, word).count).to eq(1)
    end

    it "returns 2 unused tags -> one user" do
      UserWord.create!(user: user, word: word)
      UserWord.create!(user: user, word: word_2)

      UserTag.create!(user: user, tag: tag)
      UserTag.create!(user: user, tag: tag_2)

      wt = WordTag.create!(word: word, tag: tag)
      wt_2 = WordTag.create!(word: word, tag: tag_2)

      UserWordTag.create!(user: user, word_tag: wt)
      UserWordTag.create!(user: user, word_tag: wt_2)

      expect(unused_tags(user, word_2).count).to eq(2)
    end
  end
end
