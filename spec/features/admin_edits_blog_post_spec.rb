require 'rails_helper'

feature "admin edits blog post", %{

  As an admin user,
  I want to update a blog post.
} do

  # Acceptance Criteria
  #
  # [x] I can visit /blogs/:id/edit
  # [x] I can see a form
  # [x] I see a button to update the post
  # [x] I can see errors if info isn't valid

  describe "\n admin updates blog post -->" do
    let(:blog_post) { FactoryGirl.create(:blog_post) }
    let(:brainiac) { FactoryGirl.create(:user, role: "brainiac") }
    let(:teacher) { FactoryGirl.create(:user, role: "teacher") }
    let(:admin) { FactoryGirl.create(:user, role: "admin") }

    scenario "scenario: guest tries to edit blog" do
      visit edit_blog_post_path(blog_post)

      expect(page).to have_content("Yikes! Admins only ;)")
      expect(page).not_to have_content("New Blog")
    end

    scenario "scenario: brainiac tries to edit blog" do
      log_in_as(brainiac)

      visit edit_blog_post_path(blog_post)

      expect(page).to have_content("Yikes! Admins only ;)")
      expect(page).not_to have_content("New Blog")
    end

    scenario "scenario: teacher tries to edit blog" do
      log_in_as(teacher)

      visit edit_blog_post_path(blog_post)

      expect(page).to have_content("Yikes! Admins only ;)")
      expect(page).not_to have_content("New Blog")
    end

    scenario "scenario: with valid data" do
      log_in_as(admin)

      visit edit_blog_post_path(blog_post)

      fill_in "Title", with: "Updated Title"
      fill_in "Content", with: "Updated Content"
      fill_in "Icon", with: "gamepad"
      fill_in "Slug", with: "updated_title"

      click_on "Save changes"

      expect(page).to have_content("Changes successfully made.")
      expect(page).to_not have_content("error")
      expect(page).to_not have_content("fix")
    end

    scenario "scenario: with invalid data" do
      log_in_as(admin)

      visit edit_blog_post_path(blog_post)

      fill_in "Title", with: ""
      fill_in "Content", with: ""
      fill_in "Icon", with: ""
      fill_in "Slug", with: ""

      click_on "Save changes"

      expect(page).not_to have_content("Changes successfully made.")
      expect(page).to have_content("Changes not successfully made.")
    end
  end
end
