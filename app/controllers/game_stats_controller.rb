class GameStatsController < ApplicationController
	def funds_one
		@game = Game.find_by(name: "Speed Spelling")
		@word = Word.find(params[:word_id])
		@user_word = UserWord.object(current_user, @word)

		if @user_word
			@game_stat = GameStat.universal(
				@user_word,
				@game,
				params[:time_started],
				params[:time_ended]
			)
			@game_stat.num_typed = params[:uniq_data][:num_typed]

			if @game_stat.save
				render json: { errors: "Success: GameStat #{@game_stat.id} updated." }
			else
				render json: { errors: @game_stat.errors.full_messages) }
			end
		else
			render json: { errors: "No GameStatController update needed." }
		end
	end
end
