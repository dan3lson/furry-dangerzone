require 'rails_helper'

feature "add creates blog post", %{

  As an admin,
  I want to create a new
  blog post so folks can
  read it.
} do

  # Acceptance Criteria
  #
  # [x] I can visit /blogs/new
  # [x] I see a form
  # [x] I see a success-message

  describe "\n admin creates blog -->" do
    let!(:brainiac) { FactoryGirl.create(:user) }
    let!(:teacher) { FactoryGirl.create(:user, role: "teacher") }
    let!(:admin) { FactoryGirl.create(:user, role: "admin") }

    scenario "scenario: guest tries to create blog" do
      visit new_blog_post_path

      expect(page).to have_content("Yikes! Admins only ;)")
      expect(page).not_to have_content("New Blog")
    end

    scenario "scenario: brainiac tries to create blog" do
      log_in_as(brainiac)

      visit new_blog_post_path

      expect(page).to have_content("Yikes! Admins only ;)")
      expect(page).not_to have_content("New Blog")
    end

    scenario "scenario: teacher tries to create blog" do
      log_in_as(teacher)

      visit new_blog_post_path

      expect(page).to have_content("Yikes! Admins only ;)")
      expect(page).not_to have_content("New Blog")
    end

    scenario "scenario: user(admin) with valid data" do
      log_in_as(admin)

      visit new_blog_post_path

      fill_in "Title", with: "New Blog Post Title"
      fill_in "Content", with: "This is content for this new blog post."
      fill_in "Icon", with: "gamepad"
      fill_in "Slug", with: "new_blog_post_title"

      click_on "Create blog"

      expect(page).to have_content("Post successfully created.")
      expect(BlogPost.count).to eq(1)
      expect(page).to_not have_content("error")
      expect(page).to_not have_content("fix")
    end

    scenario "scenario: user(admin) with invalid data" do
      log_in_as(admin)

      visit new_blog_post_path

      fill_in "Title", with: ""
      fill_in "Content", with: ""
      fill_in "Icon", with: ""
      fill_in "Slug", with: ""

      click_on "Create blog"

      expect(page).not_to have_content("Post successfully created.")
      expect(BlogPost.count).to eq(0)
      expect(page).to have_content("error")
      expect(page).to have_content("fix")
    end
  end
end
