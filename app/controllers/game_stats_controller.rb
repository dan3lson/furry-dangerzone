class GameStatsController < ApplicationController
	def update
		@word = Word.find(params[:word_id])
		@user_word = UserWord.find_by(user: current_user, word: @word)
		@game = Game.find_by(name: params[:game_name])
		@game_stat = GameStat.where(
			game: @game, user_word: @user_word
		).first_or_initialize
		@time_spent = params[:time_spent_in_min].to_f.round(2)

		@game_stat.num_played += 1
		@game_stat.time_spent += @time_spent

		if @game_stat.save
			msg = "Success: GameStat #{@game_stat.id} num_played and time_spent "
			msg_2 = "updated for UW #{@user_word.id} -> #{@user_word.word.name}."

			render json: { errors: msg << msg_2 }
		else
			msg = "ERROR: GameStat #{@game_stat.id} num_played OR time_spent not "
			msg_2 = "successfully updated for UW #{@user_word.id} -> "
			msg_3 = "#{@user_word.word.name}."

			rener json: {	errors: msg << msg_2 << msg_3 }
		end
	end
end
