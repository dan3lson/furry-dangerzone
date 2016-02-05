require 'rails_helper'

feature "anyone comments on blog", %{

  As a person,
  I want to comment on
  on a blog post.
} do

  # Acceptance Criteria
  #
  # [x] I can visit a blog page
  #     and see a comment form
  # [x] I can see appropriate messages

  describe "\n anyone comment on blog post -->" do
    let(:user) { FactoryGirl.create(:user) }
    let(:teacher) { FactoryGirl.create(:user, role: "teacher") }
    let(:student) { FactoryGirl.create(:user, role: "student") }
    let(:admin) { FactoryGirl.create(:user, role: "admin") }
    let(:blog_post) { FactoryGirl.create(:blog_post) }

    scenario "scenario: anyone can see a comments section" do
      visit blog_post_path(blog_post)

      expect(page).to have_css(".blog-comment-form")
      expect(page).to have_content("Join the conversation")
      expect(page).not_to have_content("Yikes! Please log in first to do that.")
    end

    scenario "scenario: guest tries with valid data" do
      visit blog_post_path(blog_post)

      fill_in "Description", with: "I love the name <3!"

      click_on "Submit"

      expect(page).to have_content("Thanks for your comment!")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("error")
      expect(Comment.count).to eq(1)
      expect(Comment.first.user).to eq(nil)
    end

    scenario "scenario: guest tries with invalid data" do
      visit blog_post_path(blog_post)

      click_on "Submit"

      expect(page).to have_content("Yikes")
      expect(page).not_to have_content("Thanks for your comment!")
      expect(Comment.count).to eq(0)
    end

    scenario "scenario: user tries with valid data" do
      log_in_as(user)

      visit blog_post_path(blog_post)

      fill_in "Description", with: "I love the name <3!"

      click_on "Submit"

      expect(page).to have_content("Thanks for your comment!")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("error")
      expect(Comment.count).to eq(1)
      expect(Comment.first.user.username).to eq(user.username)
    end

    scenario "scenario: user tries with invalid data" do
      log_in_as(user)

      visit blog_post_path(blog_post)

      click_on "Submit"

      expect(page).to have_content("Yikes")
      expect(page).not_to have_content("Thanks for your comment!")
      expect(Comment.count).to eq(0)
    end

    scenario "scenario: teacher tries with valid data" do
      log_in_as(teacher)

      visit blog_post_path(blog_post)

      fill_in "Description", with: "I love the name <3!"

      click_on "Submit"

      expect(page).to have_content("Thanks for your comment!")
      expect(page).not_to have_content("Yikes!")
      expect(page).not_to have_content("error")
      expect(Comment.count).to eq(1)
      expect(Comment.first.user.username).to eq(teacher.username)
    end

    scenario "scenario: teacher tries with invalid data" do
      log_in_as(teacher)

      visit blog_post_path(blog_post)

      click_on "Submit"

      expect(page).to have_content("Yikes")
      expect(page).not_to have_content("Thanks for your comment!")
      expect(Comment.count).to eq(0)
    end
  end
end
