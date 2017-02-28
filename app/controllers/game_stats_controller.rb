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
				render json: { errors: @game_stat.errors.full_messages }
			end
		else
			render json: { errors: "No GameStatController update needed." }
		end
	end

	def funds_two
		@game = Game.find_by(name: "Jumbled Letters")
		@word = Word.find(params[:word_id])
		@user_word = UserWord.object(current_user, @word)

		if @user_word
			@game_stat = GameStat.universal(
				@user_word,
				@game,
				params[:time_started],
				params[:time_ended]
			)
			@game_stat.num_bad_clicks = params[:uniq_data][:num_bad_clicks]

			if @game_stat.save
				render json: { errors: "Success: GameStat #{@game_stat.id} updated." }
			else
				render json: { errors: @game_stat.errors.full_messages }
			end
		else
			render json: { errors: "No GameStatController update needed." }
		end
	end

	def funds_three
		@game = Game.find_by(name: "Say It Right")
		@word = Word.find(params[:word_id])
		@user_word = UserWord.object(current_user, @word)

		if @user_word
			@game_stat = GameStat.universal(
				@user_word,
				@game,
				params[:time_started],
				params[:time_ended]
			)
			@game_stat.num_heard = params[:uniq_data][:num_heard]

			if @game_stat.save
				render json: { errors: "Success: GameStat #{@game_stat.id} updated." }
			else
				render json: { errors: @game_stat.errors.full_messages }
			end
		else
			render json: { errors: "No GameStatController update needed." }
		end
	end

	def funds_four
		@game = Game.find_by(name: "Decisions, Decisions")
		@word = Word.find(params[:word_id])
		@user_word = UserWord.object(current_user, @word)
		@meaning_alt = MeaningAlt.find(params[:uniq_data][:meaning_alt_id])

		if @user_word
			@game_stat = GameStat.universal(
				@user_word,
				@game,
				params[:time_started],
				params[:time_ended]
			)
			@game_stat.result = params[:uniq_data][:result]
			@game_stat_meaning_alt = GameStatMeaningAlt.new(
				game_stat: @game_stat,
				meaning_alt: @meaning_alt
			)

			if @game_stat_meaning_alt.save
				if @game_stat.save
					render json: { errors:
						[
							"Success: GameStatMeaningAlt #{@game_stat_meaning_alt.id} saved.",
							"Success: GameStat #{@game_stat.id} updated."
						]
					}
				else
					render json: { errors: @game_stat.errors.full_messages }
				end
			else
				render json: { errors: @game_stat_meaning_alt.errors.full_messages }
			end
		else
			render json: { errors: "No GameStatController update needed." }
		end
	end

	def funds_five
		@game = Game.find_by(name: "Examples/Non-Examples")
		@word = Word.find(params[:word_id])
		@user_word = UserWord.object(current_user, @word)
		@example_non_example = ExampleNonExample.find(
			params[:uniq_data][:ex_non_ex_id]
		)

		if @user_word
			@game_stat = GameStat.universal(
				@user_word,
				@game,
				params[:time_started],
				params[:time_ended]
			)
			@game_stat.result = params[:uniq_data][:result]
			@game_stat_ex_non_ex = GameStatExampleNonExample.new(
				game_stat: @game_stat,
				example_non_example: @example_non_example
			)

			if @game_stat_ex_non_ex.save
				if @game_stat.save
					render json: { errors: [
						"Success: GSExNonEx #{@game_stat_ex_non_ex.id} saved.",
						"Success: GameStat #{@game_stat.id} updated."
						]
					}
				else
					render json: { errors: @game_stat.errors.full_messages }
				end
			else
				render json: { errors: @game_stat_ex_non_ex.errors.full_messages }
			end
		else
			render json: { errors: "No GameStatController update needed." }
		end
	end

	def funds_six
		@game = Game.find_by(name: "Syns vs Ants")
		@word = Word.find(params[:word_id])
		@user_word = UserWord.object(current_user, @word)

		if @user_word
			@game_stat = GameStat.universal(
				@user_word,
				@game,
				params[:time_started],
				params[:time_ended]
			)
			@game_stat.type = params[:uniq_data][:type]
			@game_stat.result = params[:uniq_data][:result]
			@game_stat.word_name = params[:uniq_data][:word_name]

			if @game_stat.save
				render json: { errors: "Success: GameStat #{@game_stat.id} updated." }
			else
				render json: { errors: @game_stat.errors.full_messages }
			end
		else
			render json: { errors: "No GameStatController update needed." }
		end
	end
end
