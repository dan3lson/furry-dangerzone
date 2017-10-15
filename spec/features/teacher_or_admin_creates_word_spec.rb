require 'rails_helper'

feature "teacher or admin creates word", %{

  As a(n) teacher or admin,
  I want to create a new
  word.
} do

  # Acceptance Criteria
  #
  # [x] I can visit school/words/new
  # [x] I see a word form
  # [x] I can see a success or error-message
  #     depending on how I submit the form

  describe "\n teacher or admin creates word -->" do
    let!(:student) { FactoryGirl.create(:user) }
    let!(:admin) { FactoryGirl.create(:user, type: "Admin") }
    let!(:teacher) { FactoryGirl.create(:user, type: "Teacher") }

    scenario "scenario: guest tries to create word" do
      visit new_school_word_path

      expect(page).to have_content("Please log in first.")
      expect(page).not_to have_content("New Word")
    end

    scenario "scenario: user (non-teacher/non-admin) tries to create word" do
      log_in_as(student)

      visit new_school_word_path

      expect(page).to have_content("Access denied.")
      expect(page).not_to have_content("New Word")
    end

    scenario "scenario: user (admin) with valid data" do
      log_in_as(admin)

      visit new_school_word_path

      fill_in "Name", with: "word_name"
      fill_in "Definition", with: "word_definition"
      fill_in "Phonetic spelling", with: "word_phonetic_spelling"
      fill_in "Part of speech", with: "word_part_of_speech"
      attach_file :word_photo, "#{Rails.root}/spec/support/images/photo.jpg"
      click_on "Create"

      expect(page).to have_content("Success!")
      expect(Word.count).to eq(1)
      expect(Word.first.user).to_not eq(nil)
      expect(page).to_not have_content("that word and defintion already exists")

      admin.words << Word.first

      visit "/myLeksi/#{Word.first.id}"

      expect(page).to have_css("img[src*='photo.jpg']")
    end

    scenario "scenario: user (teacher) with valid data" do
      log_in_as(teacher)

      visit new_school_word_path

      fill_in "Name", with: "word_name"
      fill_in "Part of speech", with: "word_part_of_speech"
      fill_in "Phonetic spelling", with: "word_phonetic_spelling"
      fill_in "Definition", with: "word_definition"

      click_on "Create"

      expect(page).to have_content("Success! You created \'word_name\'.")
      expect(Word.count).to eq(1)
      expect(page).to_not have_content("that word and defintion already exists")
      expect(page).to_not have_content("Please fix")
      expect(page).to_not have_content("error")
      expect(page).to_not have_content("fix")
    end

    scenario "scenario: user (teacher) with all invalid data" do
      log_in_as(teacher)

      visit new_school_word_path

      fill_in "Name", with: ""
      fill_in "Part of speech", with: ""
      fill_in "Phonetic spelling", with: ""
      fill_in "Definition", with: ""

      click_on "Create"

      expect(page).to_not have_content("Success! You created \'word_name\'.")
      expect(Word.count).to eq(0)
      expect(page).to have_content("Please fix")
      expect(page).to have_content("error")
      expect(page).to have_content("fix")
    end

    scenario "scenario: user (teacher) with mostly invalid data" do
      log_in_as(teacher)

      visit new_school_word_path

      fill_in "Name", with: "word_name"
      fill_in "Part of speech", with: "word_part_of_speech"
      fill_in "Phonetic spelling", with: "word_phonetic_spelling"
      fill_in "Definition", with: ""

      click_on "Create"

      expect(page).to_not have_content("Success! You created \'word_name\'.")
      expect(Word.count).to eq(0)
      expect(page).to have_content("Please fix")
      expect(page).to have_content("error")
      expect(page).to have_content("fix")
    end

    scenario "scenario: user (teacher) with same data as previous word" do
      log_in_as(teacher)

      visit new_school_word_path

      fill_in "Name", with: "word_name"
      fill_in "Part of speech", with: "word_part_of_speech"
      fill_in "Phonetic spelling", with: "word_phonetic_spelling"
      fill_in "Definition", with: "word_definition"

      click_on "Create"

      expect(Word.count).to eq(1)
      fill_in "Name", with: "word_name"
      fill_in "Part of speech", with: "word_part_of_speech"
      fill_in "Phonetic spelling", with: "word_phonetic_spelling"
      fill_in "Definition", with: "word_definition"

      click_on "Create"

      expect(page).to_not have_content("Success! You created \'word_name\'.")
      expect(page).to have_content("that word and defintion already exists")
    end
  end
end
