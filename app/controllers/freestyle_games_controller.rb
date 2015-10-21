class FreestyleGamesController < ApplicationController
	def create
		@word = Word.find(params[:word_id])
		@user_word = UserWord.find_by(user: current_user, word: @word)
		@uwgl_freestyles = @user_word.uwgl_freestyles
		@first_uwgl_freestyle_id = @uwgl_freestyles.first.id
		@uwgl_freestyle_responses = @uwgl_freestyles.map { |uwgl|
			FreestyleResponse.find_by(user_word_game_level_id: uwgl.id)
		}
		@freestyle_response_ids = FreestyleResponse.pluck(:user_word_game_level_id)
		@freestyle_responses_before = FreestyleResponse.count
		@responses = params[:freestyle_responses]

		@updated_freestyle_responses = 0

		if @freestyle_response_ids.include?(@first_uwgl_freestyle_id)

			@uwgl_freestyles.each_with_index do |uwgl, i|
				@freestyle_response = FreestyleResponse.find_by(
					user_word_game_level_id: uwgl.id
				)
				@freestyle_response.input = @responses[i]

				@updated_freestyle_responses += 1 if @freestyle_response.save
			end

			if @updated_freestyle_responses == 12
				render json: {
					errors: "Success: 12 F-Responses updated for UW #{@user_word.id}."
				}
			else
				render json: {
					errors: "ERROR: 12 F-Responses not updated for #{@user_word.id}."
				}
			end
		else
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
