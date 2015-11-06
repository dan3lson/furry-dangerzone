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


  pending "\n user views freestyle responses -->" do
		let!(:user_word) { FactoryGirl.create(:user_word) }
		let(:word) { user_word.word }
		let(:user) { user_word.user }

    scenario "scenario: for one word" do
			game_fundamental = Game.create!(
				name: "Fundamentals",
				description: "Be creative"
			)
			game_jeopardy = Game.create!(
				name: "Jeopardy",
				description: "Be creative"
			)
			game_freestyle = Game.create!(
				name: "Freestyle",
				description: "Be creative"
			)

			level_1 = Level.create!(
				focus: "Fundamentals focus 1",
				direction: "Type the word below:"
			)
			level_2 = Level.create!(
				focus: "Fundamentals focus 2",
				direction: "Direction"
			)
			level_3 = Level.create!(
				focus: "Fundamentals focus 3",
				direction: "Direction"
			)
			level_4 = Level.create!(
				focus: "Fundamentals focus 4",
				direction: "Direction"
			)
			level_5 = Level.create!(
				focus: "Fundamentals focus 5",
				direction: "Direction"
			)
			level_6 = Level.create!(
				focus: "Fundamentals focus 6",
				direction: "Direction"
			)
			level_7 = Level.create!(
				focus: "Fundamentals focus 7",
				direction: "Direction"
			)
			level_8 = Level.create!(
				focus: "Fundamentals focus 8",
				direction: "Direction"
			)
			level_9 = Level.create!(
				focus: "Jeopardy focus 9",
				direction: "Type the word below:"
			)
			level_10 = Level.create!(
				focus: "Jeopardy focus 10",
				direction: "Direction"
			)
			level_11 = Level.create!(
				focus: "Jeopardy focus 11",
				direction: "Direction"
			)
			level_12 = Level.create!(
				focus: "Jeopardy focus 12",
				direction: "Direction"
			)
			level_13 = Level.create!(
				focus: "Jeopardy focus 13",
				direction: "Direction"
			)
			level_14 = Level.create!(
				focus: "Jeopardy focus 14",
				direction: "Direction"
			)
			level_15 = Level.create!(
				focus: "Jeopardy focus 15",
				direction: "Direction"
			)
			level_16 = Level.create!(
				focus: "Jeopardy focus 16",
				direction: "Direction"
			)
			level_17 = Level.create!(
				focus: "Jeopardy focus 17",
				direction: "Direction"
			)
			level_18 = Level.create!(
				focus: "Jeopardy focus 18",
				direction: "Direction"
			)
			level_19 = Level.create!(
				focus: "Jeopardy focus 19",
				direction: "Direction"
			)
			level_20 = Level.create!(
				focus: "Jeopardy focus 20",
				direction: "Direction"
			)
			level_21 = Level.create!(
				focus: "Jeopardy focus 21",
				direction: "Type the word below:"
			)
			level_22 = Level.create!(
				focus: "Jeopardy focus 22",
				direction: "Direction"
			)
			level_23 = Level.create!(
				focus: "Jeopardy focus 23",
				direction: "Direction"
			)
			level_24 = Level.create!(
				focus: "Jeopardy focus 24",
				direction: "Direction"
			)
			level_25 = Level.create!(
				focus: "Jeopardy focus 25",
				direction: "Direction"
			)
			level_26 = Level.create!(
				focus: "Jeopardy focus 26",
				direction: "Direction"
			)
			level_27 = Level.create!(
				focus: "Jeopardy focus 27",
				direction: "Direction"
			)
			level_28 = Level.create!(
				focus: "Jeopardy focus 28",
				direction: "Direction"
			)
			level_29 = Level.create!(
				focus: "Freestyle focus 29",
				direction: "Direction"
			)
			level_30 = Level.create!(
				focus: "Freestyle focus 30",
				direction: "Direction"
			)
			level_31 = Level.create!(
				focus: "Freestyle focus 31",
				direction: "Direction"
			)
			level_32 = Level.create!(
				focus: "Freestyle focus 32",
				direction: "Direction"
			)
			level_33 = Level.create!(
				focus: "Freestyle focus 33",
				direction: "Direction"
			)
			level_34 = Level.create!(
				focus: "Freestyle focus 34",
				direction: "Type the word below:"
			)
			level_35 = Level.create!(
				focus: "Freestyle focus 35",
				direction: "Direction"
			)
			level_36 = Level.create!(
				focus: "Freestyle focus 36",
				direction: "Direction"
			)
			level_37 = Level.create!(
				focus: "Freestyle focus 37",
				direction: "Direction"
			)
			level_38 = Level.create!(
				focus: "Freestyle focus 38",
				direction: "Direction"
			)
			level_39 = Level.create!(
				focus: "Freestyle focus 39",
				direction: "Direction"
			)
			level_40 = Level.create!(
				focus: "Freestyle focus 40",
				direction: "Direction"
			)

			fund_gl_1 = GameLevel.create!(game: game_fundamental, level: level_1)
			fund_gl_2 = GameLevel.create!(game: game_fundamental, level: level_2)
			fund_gl_3 = GameLevel.create!(game: game_fundamental, level: level_3)
			fund_gl_4 = GameLevel.create!(game: game_fundamental, level: level_4)
			fund_gl_5 = GameLevel.create!(game: game_fundamental, level: level_5)
			fund_gl_6 = GameLevel.create!(game: game_fundamental, level: level_6)
			fund_gl_7 = GameLevel.create!(game: game_fundamental, level: level_7)
			fund_gl_8 = GameLevel.create!(game: game_fundamental, level: level_8)
			jeop_gl_9 = GameLevel.create!(game: game_jeopardy, level: level_9)
			jeop_gl_10 = GameLevel.create!(game: game_jeopardy, level: level_10)
			jeop_gl_11 = GameLevel.create!(game: game_jeopardy, level: level_11)
			jeop_gl_12 = GameLevel.create!(game: game_jeopardy, level: level_12)
			jeop_gl_13 = GameLevel.create!(game: game_jeopardy, level: level_13)
			jeop_gl_14 = GameLevel.create!(game: game_jeopardy, level: level_14)
			jeop_gl_15 = GameLevel.create!(game: game_jeopardy, level: level_15)
			jeop_gl_16 = GameLevel.create!(game: game_jeopardy, level: level_16)
			jeop_gl_17 = GameLevel.create!(game: game_jeopardy, level: level_17)
			jeop_gl_18 = GameLevel.create!(game: game_jeopardy, level: level_18)
			jeop_gl_19 = GameLevel.create!(game: game_jeopardy, level: level_19)
			jeop_gl_20 = GameLevel.create!(game: game_jeopardy, level: level_20)
			jeop_gl_21 = GameLevel.create!(game: game_jeopardy, level: level_21)
			jeop_gl_22 = GameLevel.create!(game: game_jeopardy, level: level_22)
			jeop_gl_23 = GameLevel.create!(game: game_jeopardy, level: level_23)
			jeop_gl_24 = GameLevel.create!(game: game_jeopardy, level: level_24)
			jeop_gl_25 = GameLevel.create!(game: game_jeopardy, level: level_25)
			jeop_gl_26 = GameLevel.create!(game: game_jeopardy, level: level_26)
			jeop_gl_27 = GameLevel.create!(game: game_jeopardy, level: level_27)
			jeop_gl_28 = GameLevel.create!(game: game_jeopardy, level: level_28)
			free_gl_29 = GameLevel.create!(game: game_freestyle, level: level_29)
			free_gl_30 = GameLevel.create!(game: game_freestyle, level: level_30)
			free_gl_31 = GameLevel.create!(game: game_freestyle, level: level_31)
			free_gl_32 = GameLevel.create!(game: game_freestyle, level: level_32)
			free_gl_33 = GameLevel.create!(game: game_freestyle, level: level_33)
			free_gl_34 = GameLevel.create!(game: game_freestyle, level: level_34)
			free_gl_35 = GameLevel.create!(game: game_freestyle, level: level_35)
			free_gl_36 = GameLevel.create!(game: game_freestyle, level: level_36)
			free_gl_37 = GameLevel.create!(game: game_freestyle, level: level_37)
			free_gl_38 = GameLevel.create!(game: game_freestyle, level: level_38)
			free_gl_39 = GameLevel.create!(game: game_freestyle, level: level_39)
			free_gl_40 = GameLevel.create!(game: game_freestyle, level: level_40)

			UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_1)
			UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_2)
			UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_3)
			UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_4)
			UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_5)
			UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_6)
			UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_7)
			UserWordGameLevel.create!(user_word: user_word, game_level: fund_gl_8)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_9)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_10)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_11)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_12)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_13)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_14)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_15)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_16)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_17)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_18)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_19)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_20)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_21)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_22)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_23)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_24)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_25)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_26)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_27)
			UserWordGameLevel.create!(user_word: user_word, game_level: jeop_gl_28)
			uwgl_1 = UserWordGameLevel.create!(user_word: user_word,
				game_level: free_gl_29
			)
			uwgl_2 = UserWordGameLevel.create!(user_word: user_word,
				game_level: free_gl_30
			)
			uwgl_3 = UserWordGameLevel.create!(user_word: user_word,
				game_level: free_gl_31
			)
			uwgl_4 = UserWordGameLevel.create!(user_word: user_word,
				game_level: free_gl_32
			)
			uwgl_5 = UserWordGameLevel.create!(user_word: user_word,
				game_level: free_gl_33
			)
			uwgl_6 = UserWordGameLevel.create!(user_word: user_word,
				game_level: free_gl_34
			)
			uwgl_7 = UserWordGameLevel.create!(user_word: user_word,
				game_level: free_gl_35
			)
			uwgl_8 = UserWordGameLevel.create!(user_word: user_word,
				game_level: free_gl_36
			)
			uwgl_9 = UserWordGameLevel.create!(user_word: user_word,
				game_level: free_gl_37
			)
			uwgl_10 = UserWordGameLevel.create!(user_word: user_word,
				game_level: free_gl_38
			)
			uwgl_11 = UserWordGameLevel.create!(user_word: user_word,
				game_level: free_gl_39
			)
			uwgl_12 = UserWordGameLevel.create!(user_word: user_word,
				game_level: free_gl_40
			)

			user_word.uwgl_fundamentals.each do |uwgl|
				uwgl.status = "complete"
				uwgl.save
			end

			user_word.uwgl_jeopardys.each do |uwgl|
				uwgl.status = "complete"
				uwgl.save
			end

			user_word.uwgl_freestyles.each do |uwgl|
				uwgl.status = "complete"
				uwgl.save
			end

			FreestyleResponse.create!(input: "SM 1", user_word_game_level: uwgl_1)
			FreestyleResponse.create!(input: "SM 2", user_word_game_level: uwgl_2)
			FreestyleResponse.create!(input: "SM 3", user_word_game_level: uwgl_3)
			FreestyleResponse.create!(input: "WM 1", user_word_game_level: uwgl_4)
			FreestyleResponse.create!(input: "WM 2", user_word_game_level: uwgl_5)
			FreestyleResponse.create!(input: "WM 3", user_word_game_level: uwgl_6)
			FreestyleResponse.create!(input: "DM 1", user_word_game_level: uwgl_7)
			FreestyleResponse.create!(input: "DM 2", user_word_game_level: uwgl_8)
			FreestyleResponse.create!(input: "DM 3", user_word_game_level: uwgl_9)
			FreestyleResponse.create!(input: "SEx 1", user_word_game_level: uwgl_10)
			FreestyleResponse.create!(input: "SEx 2", user_word_game_level: uwgl_11)
			FreestyleResponse.create!(input: "SEx 3", user_word_game_level: uwgl_12)

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
    end

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
