require 'rails_helper'

feature "user views freestyle responses", %{

  As a user,
  I want to view my freestyle responses
  for one of my words.
} do

  # Acceptance Criteria
  #
  # [] Clicking on a word lets me
  #    see the freestyle responses
	#    for it


  describe "\n user views freestyle responses -->" do
		let!(:user_word) { FactoryGirl.create(:user_word, games_completed: 3) }
		let(:word) { user_word.word }
		let(:user) { user_word.user }

    scenario "scenario: for one word UPDATED FREESTYLE_RESPONSE TABLE" do
			FreestyleResponse.create!(input: "SM 1", user_word: user_word,
				focus: "Semantic Map"
			)
			FreestyleResponse.create!(input: "SM 2", user_word: user_word,
				focus: "Semantic Map"
			)
			FreestyleResponse.create!(input: "SM 3", user_word: user_word,
				focus: "Semantic Map"
			)
			FreestyleResponse.create!(input: "WM 1", user_word: user_word,
				focus: "Word Map"
			)
			FreestyleResponse.create!(input: "WM 2", user_word: user_word,
				focus: "Word Map"
			)
			FreestyleResponse.create!(input: "WM 3", user_word: user_word,
				focus: "Word Map"
			)
			FreestyleResponse.create!(input: "DM 1", user_word: user_word,
				focus: "Definition Map"
			)
			FreestyleResponse.create!(input: "DM 2", user_word: user_word,
				focus: "Definition Map"
			)
			FreestyleResponse.create!(input: "DM 3", user_word: user_word,
				focus: "Definition Map"
			)
			FreestyleResponse.create!(input: "SEx 1", user_word: user_word,
				focus: "Sentence Example"
			)
			FreestyleResponse.create!(input: "SEx 2", user_word: user_word,
				focus: "Sentence Example"
			)
			FreestyleResponse.create!(input: "SEx 3", user_word: user_word,
				focus: "Sentence Example"
			)

			log_in_as(user)

			visit myLeksi_path

			click_on word.name.capitalize

			expect(page).to have_content("Freestyle Game Responses")
			expect(page).to have_content("Semantic Map")
			expect(page).to have_content("SM 1")
			expect(page).to have_content("SM 2")
			expect(page).to have_content("SM 3")
			expect(page).to have_content("Word Map")
			expect(page).to have_content("WM 1")
			expect(page).to have_content("WM 2")
			expect(page).to have_content("WM 3")
			expect(page).to have_content("Definition Map")
			expect(page).to have_content("DM 1")
			expect(page).to have_content("DM 2")
			expect(page).to have_content("DM 3")
			expect(page).to have_content("Sentence Examples")
			expect(page).to have_content("SEx 1")
			expect(page).to have_content("SEx 2")
			expect(page).to have_content("SEx 3")
			expect(FreestyleResponse.count).to eq(12)
			expect(user_word.freestyle_responses.count).to eq(12)
    end
  end
end
