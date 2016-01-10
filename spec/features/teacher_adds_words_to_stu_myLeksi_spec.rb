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
  # [x] I can see "checkboxes"
  #    to select students
  #    individually
  # [x] I can see a "select all"
  #    option
  # [x] I can see the results
  #    of this process

  describe "\n teacher adds words to student(s) myLeksi -->" do
    before :each do
      FactoryGirl.create(:version)

      usernames = %w(
        22annenberg
        22bloch
        22chawla
        22kellner
        22musso
        22nino
        22parr
        22pass
        22riordan
        22seldman
        22spencer
        22sriram
        22tarta
        22vail
        22watts
        22yamazaki
        22zenkerc
        22ball
        22bugdaycay
        22caiola
        22earle
        22friedman
        22gott
        22gund-morrow
        22halverstadt
        22juneja
        22luard
        22palladino
        22pratofiorito
        22ragins
        22tartj
        22weber
        22zenkerm
      )

      usernames.each do |u|
        User.create!(
          username: u,
          password: "password",
          password_confirmation: "password",
          role: "student",
          email: ""
        )
      end
    end

    let(:teacher) { FactoryGirl.create(:user, role: "teacher") }

    scenario "scenario: see link to add words for student" do
      log_in_as(teacher)

      visit menu_path

      click_on "Activate Teacher Edition"

      expect(page).to have_link("Add words for students")
    end

    scenario "scenario: see available classes to begin process" do
      log_in_as(teacher)

      visit school_student_words_path

      expect(page).to have_content("Step 1. Select class")
      expect(page).to have_css("#class-1")
      expect(page).to have_css("#class-2")
    end

    scenario "scenario: step 1 -> select a class", js: true do
      log_in_as(teacher)

      visit school_student_words_path

      find("#class-1").click
      sleep(1)

      expect(page).to have_content("Step 2. Select student(s)")
      expect(page).to have_css(".stu-bubble", count: 17)
      expect(page).to have_css("#selected-students")
    end

    scenario "scenario: step 2 -> select 0 students: cant continue", js: true do
      log_in_as(teacher)

      visit school_student_words_path

      find("#class-1").click
      sleep(1)

      expect(page).to have_content("Number selected: 0")
      expect(page).not_to have_button("Continue")
    end

    scenario "scenario: step 2 -> select 1 student: cant continue", js: true do
      log_in_as(teacher)

      visit school_student_words_path

      find("#class-1").click
      sleep(1)

      find("#stu-bubble-22annenberg").click
      find("#stu-bubble-22annenberg").click

      expect(page).to have_content("Number selected: 0")
      expect(page).not_to have_button("Continue")
    end

    scenario "scenario: step 2 -> select 1 student: can continue", js: true do
      log_in_as(teacher)

      visit school_student_words_path

      find("#class-1").click
      sleep(1)

      find("#stu-bubble-22annenberg").click

      expect(page).to have_content("Number selected: 1")
      expect(page).to have_button("Continue")
    end

    scenario "scenario: step 2 -> select 3 students: can continue", js: true do
      log_in_as(teacher)

      visit school_student_words_path

      find("#class-1").click
      sleep(1)

      find("#stu-bubble-22annenberg").click
      find("#stu-bubble-22chawla").click
      find("#stu-bubble-22nino").click

      expect(page).to have_content("Number selected: 3")
      expect(page).to have_button("Continue")
    end

    scenario "scenario: step 2 -> select all: can continue", js: true do
      log_in_as(teacher)

      visit school_student_words_path

      find("#class-1").click
      sleep(1)

      find("#select-all").click

      expect(page).to have_content("Number selected: 17")
      expect(page).to have_button("Continue")
    end

    skip "scenario: step 3 -> cant finish", js: true do
      log_in_as(teacher)

      visit school_student_words_path

      find("#class-1").click
      sleep(1)

      find("#select-all").click

      click_on "Continue"

      expect(page).to have_content("Number selected: 0")
      expect(page).not_to have_button("Finish")
    end

    skip "scenario: step 3 -> select 1 word: can finish", js: true do
      FactoryGirl.create(:word)

      log_in_as(teacher)

      visit school_student_words_path

      find("#class-1").click
      sleep(1)

      find("#select-all").click

      click_on "Continue"

      find("#random-search-btn").click
      sleep(1)

      find(".awfs-select-word-btn").click

      expect(page).to have_content("Number selected: 1")
      expect(page).to have_button("Finish")
    end

    skip "scenario: review process completion", js: true do
      FactoryGirl.create(:word)

      log_in_as(teacher)

      visit school_student_words_path

      find("#class-1").click
      sleep(1)

      find("#select-all").click

      click_on "Continue"

      find("#random-search-btn").click
      sleep(1)

      find(".awfs-select-word-btn").click

      click_on "Finish"
      sleep(1)

      expect(page).to have_content("Students (17) Words (1)")
      expect(page).to have_content("17/17")
      expect(page).to have_content("Review")
      expect(page).to have_button("Add more")
    end
  end
end
