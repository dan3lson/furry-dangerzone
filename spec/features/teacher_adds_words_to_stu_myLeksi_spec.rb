require 'rails_helper'

feature "teacher adds words to student(s) myLeksi", %{

  As a teacher,
  I want to add words
  on behalf of my students'
  myLeksi.
} do

  # Acceptance Criteria
  #
  # [x] I can see a link from
  #    the menu to do this
  # [] I can see checkboxes
  #    to select students
  #    individually
  # [] I can see a "select all"
  #    option

  describe "\n teacher adds words to student(s) myLeksi -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let(:teacher) { FactoryGirl.create(:user, role: "teacher") }

    scenario "scenario: click menu_path and see link to add words for stu" do
      log_in_as(teacher)

      visit menu_path

      click_on "Activate Teacher\'s Edition"

      expect(page).to have_link("Add to Student(s)")
    end

    scenario "scenario: view checkboxes for each student" do
      log_in_as(teacher)

      visit menu_path

      click_on "Activate Teacher\'s Edition"
      click_on "Add to Student(s)"

      # click_on class

      expect(page).to have_css("checkbox", count: 17)
    end
  end
end
