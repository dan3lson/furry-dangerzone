class GameStatsController < ApplicationController
	def fundamentals
		@game = Game.find_by(name: "Fundamentals")
		@word = Word.find(params[:word_id])
		@user_word = UserWord.object(current_user, @word)

		if @user_word
			@game_stat = GameStat.universal(
				@user_word,
				@game,
				params[:time_started],
				params[:time_ended]
			)

			if @game_stat.save
				track_activity(@game_stat)
				render json: { response: "Success: GameStat #{@game_stat.id} created." }
			else
				render json: { response: @game_stat.errors.full_messages }
			end
		else
			render json: { response: "No GameStatsController update needed." }
		end
	end
end
