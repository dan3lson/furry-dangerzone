require 'rails_helper'

feature "user plays game one", %{

  As a user,
  I want to play the first game
  for one of my words.
} do

  # Acceptance Criteria
  #
  # [] Clicking on "start" takes me to
  #    the first level of Game 1
  # [] I can complete 8 levels or go back
  #    to /words/:id

  pending "\n user plays game one -->" do
    scenario "scenario: plays game one without stopping", js: true do
      word = Word.create(
        name: "time",
        definition: "the quantity that you measure using a clock",
        example_sentence: "Time time time, the hidden mechanism..."
      )
      user = FactoryGirl.create(:user)
      user_word = UserWord.create(user: user, word: word)
      FactoryGirl.create(:game)

      log_in_as(user)

      page.find(".hvr-float-shadow").click

      # Level 1
      fill_in "spell_the_word", with: "time"

      click_on "Continue"

      # Level 2 -> sometimes will ambiguously fail due to randomly generated
      # letters that are the same as the four below
      page.find(".letter_t").click
      page.find(".letter_i").click
      page.find(".letter_m").click
      page.find(".letter_e").click
      click_on "Continue"

      # Level 5-7 -> No syn, ant, or checkpoint needed

      # Level 8
      page.find(".rwe_row_0").click
      page.find(".rwe_row_1").click
      page.find(".rwe_row_2").click
      sleep(3)
      click_on "Finish!"
      sleep(3)

      expect(page).to have_content("Congratulations!")
      expect(page).to have_content("You\'ve completed the Fundamentals for")
      expect(page).to have_content(word.name)
      expect(page).to have_content("and earned")
      expect(page).to have_content("experience points!")
      # expect(user_word.games_completed).to eq(1)
    end
  end
end
