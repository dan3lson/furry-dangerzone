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

    scenario "scenario: plays the Fundamentals" do
      visit "/fundamentals?word_id=#{word.id}"

      expect(page).to have_content("Yikes! Log in first")
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
      log_in_as(user)

      visit "/jeopardy?word_id=#{word.id}"

      expect(page).to_not have_content("Yikes! Log in first")
    end

    scenario "scenario: plays Freestyle logged in" do
      log_in_as(user)

      visit "/freestyle?word_id=#{word.id}"

      expect(page).to_not have_content("Yikes! Log in first")
    end
  end
end
