class JeopardyResultsController < ApplicationController
	def update
		@word = Word.find(params[:word_id])
		@user_word = UserWord.find_by(user: current_user, word: @word)

		if @user_word
			@game = Game.find_by(name: params[:game_name])
			@game_stat = GameStat.where(
				game: @game, user_word: @user_word
			).first_or_initialize

			if @game_stat.save
				msg = "Success: GameStat #{@game_stat.id} jeop-result updated for "
				msg_2 = "#{@user_word.id} -> #{@user_word.word.name}."
				render json: { response: msg << msg_2	}
			else
				msg = "ERROR: GameStat #{@game_stat.id} jeop-result not "
				msg_2 = "updated for #{@user_word.id} -> #{@user_word.word.name}"
				render json: { errors: msg << msg_2 }
			end
		else
			render json: { response: "No GameStat update needed for random word." }
		end
	end
end
