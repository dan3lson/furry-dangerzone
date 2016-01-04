require 'rails_helper'

feature "guest tries to play games", %{

  As a guest,
  I want to try and play a game.
} do

  # Acceptance Criteria
  #
  # [x] I can see a message saying
  #     I must be logged in first

  describe "\n guest tries to play games -->" do
    before :each do
      FactoryGirl.create(:version)
    end

    let(:user) { FactoryGirl.create(:user) }
    let(:word) { FactoryGirl.create(:word) }
    let(:word_2) { FactoryGirl.create(:word, name: "chess_2") }
    let(:word_3) { FactoryGirl.create(:word, name: "chess_3") }
    let(:word_4) { FactoryGirl.create(:word, name: "chess_4") }
    let(:word_5) { FactoryGirl.create(:word, name: "chess_5") }

    scenario "scenario: plays the Fundamentals" do
      visit "/fundamentals?word_id=#{word.id}"

      expect(page).to have_content(word.name)
    end

    scenario "scenario: plays Jeopardy" do
      visit "/jeopardy?word_id=#{word.id}"

      expect(page).to have_content("Yikes! Log in first")
    end

    scenario "scenario: plays Freestyle" do
      visit "/freestyle?word_id=#{word.id}"

      expect(page).to have_content("Yikes! Log in first")
    end

    scenario "scenario: plays the Fundamentals logged in" do
      log_in_as(user)

      visit "/fundamentals?word_id=#{word.id}"

      expect(page).to_not have_content("Yikes! Log in first")
    end

    scenario "scenario: plays Jeopardy logged in" do
      UserWord.create!(user: user, word: word_2, games_completed: 1)
      UserWord.create!(user: user, word: word_3, games_completed: 1)
      UserWord.create!(user: user, word: word_4, games_completed: 1)
      UserWord.create!(user: user, word: word_5, games_completed: 1)

      log_in_as(user)

      visit "/jeopardy?word_id=#{word.id}"

      expect(page).to_not have_content("Yikes! Log in first")
      expect(page).to have_content("Welcome to Jeopardy")
    end

    scenario "scenario: plays Freestyle logged in", js: true do
      log_in_as(user)

      visit "/freestyle?word_id=#{word.id}"

      expect(page).to_not have_content("Yikes! Log in first")
      expect(page).to have_content("Type three words similar to")
    end
  end
end
