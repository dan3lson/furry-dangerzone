class GameStatsController < ApplicationController
	def update
		@word = Word.find(params[:word_id])
		@user_word = UserWord.find_by(user: current_user, word: @word)
		@game = Game.find_by(name: params[:game_name])
		@game_stat = GameStat.where(
			game: @game, user_word: @user_word
		).first_or_initialize

		@game_stat.num_played += 1

		if @game_stat.save
			msg = "GameStat #{@game_stat.id} successfully updated for"
			msg_2 = " #{@user_word.id} -> #{@user_word.word.name}"

			render json: {
				errors: msg << msg_2
			}
		else
			msg = "ERROR: GameStat #{@game_stat.id} NOT successfully updated for"
			msg_2 = " #{@user_word.id} -> #{@user_word.word.name}"

			rener json: {
				errors: msg << msg_2
			}
		end
	end
end