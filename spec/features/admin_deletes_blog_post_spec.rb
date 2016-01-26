require 'rails_helper'

feature "admin deletes blog post", %{

  As an admin,
  I want to delete a blog post.
} do

  # Acceptance Criteria
  #
  # [x] I can see a "delete blog post" button
  # [x] I see a message of removal-success

  describe "\n admin deletes blog post -->" do
    let!(:admin) { FactoryGirl.create(:user, role: "admin") }
    let!(:blog_post) { FactoryGirl.create(:blog_post) }

    scenario "scenario: without comments" do
      log_in_as(admin)

      visit edit_blog_post_path(blog_post)

      click_on "Delete post"

      expect(page).to have_content("Post deleted.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(BlogPost.count).to eq(0)
    end

    skip "scenario: with reviews" do
      log_in_as(admin)

      visit edit_blog_post_path(version)

      click_on "Delete post"

      expect(page).to have_content("Post deleted.")
      expect(page).not_to have_content("Yikes! Something went wrong.")
      expect(page).not_to have_content("Please try again.")
      expect(BlogPost.count).to eq(0)
      expect(Comment.count).to eq(0)
    end
  end
end
