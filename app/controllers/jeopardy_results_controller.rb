class JeopardyResultsController < ApplicationController
	def update
		@word = Word.find(params[:word_id])
		@user_word = UserWord.find_by(user: current_user, word: @word)
		@game = Game.find_by(name: params[:game_name])
		@game_stat = GameStat.where(
			game: @game, user_word: @user_word
		).first_or_initialize
		@result = params[:result]

		if @result == "won"
			@game_stat.num_jeop_won += 1
		else
			@game_stat.num_jeop_lost += 1
		end

		if @game_stat.save
			msg = "Success: GameStat #{@game_stat.id} jeop-result updated for "
			msg_2 = "#{@user_word.id} -> #{@user_word.word.name}."

			render json: { errors: msg << msg_2	}
		else
			msg = "ERROR: GameStat #{@game_stat.id} jeop-result not "
			msg_2 = "updated for #{@user_word.id} -> #{@user_word.word.name}"

			rener json: { errors: msg << msg_2 }
		end
	end
end
