class FreestyleGamesController < ApplicationController
	def create # really a create/update fusion
		@word = Word.find(params[:word_id])
		@user_word = UserWord.find_by(user: current_user, word: @word)
		@responses = params[:freestyle_responses]
		@split_responses = @responses.each_slice(3).to_a
		@sem_map_responses = @split_responses[0]
		@word_map_responses = @split_responses[1]
		@def_map_responses = @split_responses[2]
		@sent_ex_responses = @split_responses[3]

		@freestyles_for_uw = FreestyleResponse.for(@user_word)
		@freestyle_response_uw_ids = FreestyleResponse.pluck(:user_word_id)

		if @freestyle_response_uw_ids.include?(@user_word.id)
			@updated_freestyle_responses = 0

			@freestyles_for_uw.each_with_index do |fr, i|
				fr.input = @responses[i]

				@updated_freestyle_responses += 1 if fr.save
			end

			@user_word.games_completed = 3

			if @updated_freestyle_responses == 12 && @user_word.save
				render json: {
					errors: "Success: 12 F-Responses updated for UW #{@user_word.id}."
				}
			else
				render json: {
					errors: "ERROR: 12 F-Responses not updated for UW #{@user_word.id}."
				}
			end
		else
			@freestyle_responses_before = FreestyleResponse.count

			@sem_map_responses.each do |r|
				FreestyleResponse.create!(input: r,	focus: "Semantic Map",
					user_word_id: @user_word.id
				)
			end

			@word_map_responses.each do |r|
				FreestyleResponse.create!(input: r,	focus: "Word Map",
					user_word_id: @user_word.id
				)
			end

			@def_map_responses.each do |r|
				FreestyleResponse.create!(input: r,	focus: "Definition Map",
					user_word_id: @user_word.id
				)
			end

			@sent_ex_responses.each do |r|
				FreestyleResponse.create!(input: r,	focus: "Sentence Example",
					user_word_id: @user_word.id
				)
			end

			@freestyle_responses_after = FreestyleResponse.count

			@user_word.games_completed = 3

			if (@freestyle_responses_after - @freestyle_responses_before == 12) &&
				@user_word.save
				render json: {
					errors: "Success: 12 F-Responses created for UW #{@user_word.id}."
				}
			else
				render json: {
					errors: "ERROR: 12 F-Responses not created for UW #{@user_word.id}."
				}
			end
		end
	end
end
