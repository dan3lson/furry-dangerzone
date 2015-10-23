require 'rails_helper'

feature "teacher or admin creates word", %{

  As a(n) teacher or admin,
  I want to create a new
  word.
} do

  # Acceptance Criteria
  #
  # [] I can visit /words/new
  # [] I see a word form
  # [] I can see a success-message

  describe "\n teacher/admin creates word -->" do
    before :each do
      Version.create(number: "1.0.0", description: "Dope new feature!")
    end

    let!(:brainiac) { FactoryGirl.create(:user) }
    let!(:admin) { FactoryGirl.create(:user, role: "admin") }
    let!(:teacher) { FactoryGirl.create(:user, role: "teacher") }

    scenario "scenario: guest tries to create word" do
      visit new_school_word_path

      expect(page).to have_content("Yikes! Please log in first to do that.")
      expect(page).not_to have_content("New Word")
    end

    scenario "scenario: user(non-teacher/admin) tries to create word" do
      log_in_as(brainiac)

      visit new_school_word_path

      expect(page).to have_content("Yikes! That\'s not something you can do.")
      expect(page).not_to have_content("New Word")
    end

    scenario "scenario: user(admin) with valid data" do
      log_in_as(admin)

      visit new_school_word_path

      fill_in "Name", with: "word_name"
      fill_in "Part of speech", with: "word_part_of_speech"
      fill_in "Phonetic spelling", with: "word_phonetic_spelling"
      fill_in "Definition", with: "word_definition"
      fill_in "Example sentence", with: "word_example_sentence"
      click_on "Create new word"

      expect(page).to have_content("Success! You created \'word_name\'.")
      expect(Word.count).to eq(1)
      expect(page).to_not have_content("Yikes!")
      expect(page).to_not have_content("error")
      expect(page).to_not have_content("fix")
    end

    scenario "scenario: user(teacher) with valid data" do
      log_in_as(teacher)

      visit new_school_word_path

      fill_in "Name", with: "word_name"
      fill_in "Part of speech", with: "word_part_of_speech"
      fill_in "Phonetic spelling", with: "word_phonetic_spelling"
      fill_in "Definition", with: "word_definition"
      fill_in "Example sentence", with: "word_example_sentence"

      click_on "Create new word"

      expect(page).to have_content("Success! You created \'word_name\'.")
      expect(Word.count).to eq(1)
      expect(page).to_not have_content("Yikes!")
      expect(page).to_not have_content("error")
      expect(page).to_not have_content("fix")
    end

    scenario "scenario: user(teacher) with all invalid data" do
      log_in_as(teacher)

      visit new_school_word_path

      fill_in "Name", with: ""
      fill_in "Part of speech", with: ""
      fill_in "Phonetic spelling", with: ""
      fill_in "Definition", with: ""
      fill_in "Example sentence", with: ""

      click_on "Create new word"

      expect(page).to_not have_content("Success! You created \'word_name\'.")
      expect(Word.count).to eq(0)
      expect(page).to have_content("Yikes!")
      expect(page).to have_content("error")
      expect(page).to have_content("fix")
    end

    scenario "scenario: user(teacher) with mostly invalid data" do
      log_in_as(teacher)

      visit new_school_word_path

      fill_in "Name", with: "word_name"
      fill_in "Part of speech", with: "word_part_of_speech"
      fill_in "Phonetic spelling", with: "word_phonetic_spelling"
      fill_in "Definition", with: ""
      fill_in "Example sentence", with: ""

      click_on "Create new word"

      expect(page).to_not have_content("Success! You created \'word_name\'.")
      expect(Word.count).to eq(0)
      expect(page).to have_content("Yikes!")
      expect(page).to have_content("error")
      expect(page).to have_content("fix")
    end
  end
end
