class FreestyleGamesController < ApplicationController
	def create
		@word = Word.find(params[:word_id])
		@user_word = UserWord.find_by(user: current_user, word: @word)
		@responses = params[:freestyle_responses]
		@uwgl_freestyles = @user_word.uwgl_freestyles
		@freestyle_responses_before = FreestyleResponse.count

		0.upto(11) do |i|
			@freestyle_response = FreestyleResponse.create!(
				input: @responses[i],
				user_word_game_level: @uwgl_freestyles[i]
			)
		end

		@freestyle_responses_after = FreestyleResponse.count

		if @freestyle_responses_after - @freestyle_responses_before == 12
			render json: {
				errors: "Success: 12 F-Responses created for UW #{@user_word.id}."
			}
		else
			render json: {
				errors: "ERROR: 12 F-Responses not created for #{@user_word.id}."
			}
		end
	end

	def update
		@word = Word.find(params[:word_id])
		@user_word = UserWord.find_by(user: current_user, word: @word)

		@user_word.uwgl_freestyles.each do |uwgl|
			uwgl.status = "complete"
			uwgl.save!
		end

		@status = @user_word.uwgl_freestyles.map { |uwgl| uwgl.status }.uniq.first

		if @status == "complete"
			render json: {
				errors: "Success: UWGL Freestyles (UW #{@user_word.id}) updated."
			}
		else
			render json: {
				errors: "ERROR: UWGL Freestyles (UW #{@user_word.id}) NOT updated."
			}
		end
	end
end
