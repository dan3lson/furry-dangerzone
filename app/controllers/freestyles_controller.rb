class FreestylesController < ApplicationController
	def sent_stem
		@game = Game.find_by(name: "Sentence Stems")
		@word = Word.find(params[:word_id])
		@user_word = UserWord.object(current_user, @word)
		@game_stat = GameStat.universal(
			@user_word,
			@game,
			params[:time_started],
			params[:time_ended]
		)
		@msgs = { successes: [], errors: [] }

		if @game_stat.save
			@msgs[:successes] << "GameStat #{@game_stat.id} created."
			@sent_stems = params[:uniq_data]

			@sent_stems.each do |id, input|
				@free = Freestyle.new(input: input, user_word: @user_word)

				if @free.save
					@msgs[:successes] << "Free created for UW #{@user_word.id}."
					@sent_stem = SentStem.find(id)
					@fss = FreestyleSentStem.new(freestyle: @free, sent_stem: @sent_stem)

					if @fss.save
						@fss.game_stat = @game_stat
						@msgs[:successes] << "FreSentStem (@fss.id) created."
					else
						@msgs[:errors] << "FreSentStem (@fss.id) not created"
						@msgs[:errors] << @fss.errors.full_messages
					end
				else
					@msgs[:errors] << "Free not created for UW #{@user_word.id}."
					@msgs[:errors] << @free.errors.full_messages
				end
			end

			render json: { response: @msgs }
		else
			@msgs[:errors] << "GameStat not created for UW #{@user_word.id}."
			@msgs[:errors] << @game_stat.errors.full_messages
			render json: { response: @msgs }
		end
	end
end
