class GameStatsController < ApplicationController
	def update
		@word = Word.find(params[:word_id])
		@game = Game.find_by(name: params[:game_name])
		@time_spent = params[:time_spent_in_min]

		@gs_results = GameStat.update_user_word_game_stats(
			@user, @word, @game, @time_spent
		)

		render json: { errors: @gs_results }
	end
end
