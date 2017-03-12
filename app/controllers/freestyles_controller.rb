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
		else
			@msgs[:errors] << "GameStat not created for UW #{@user_word.id}."
			@msgs[:errors] << @game_stat.errors.full_messages
		end

		render json: { response: @msgs }
	end

	def word_rel
		@game = Game.find_by(name: "Word Relationships")
		@word = Word.find(params[:word_id])
		@user_word = UserWord.object(current_user, @word)
		@input = params[:uniq_data][:input]
		@free = Freestyle.new(input: @input, user_word: @user_word)
		@msgs = { successes: [], errors: [] }

		if @free.save
			@msgs[:successes] << "Free (#{@free.id}) created for UW #{@user_word.id}."
			@rel_word = Word.find(params[:uniq_data][:rel_word_id])
			@free_w_r = FreestyleRelWord.new(freestyle: @free, rel_word: @rel_word)
			@game_stat = GameStat.universal(
				@user_word,
				@game,
				params[:time_started],
				params[:time_ended]
			)

			if @game_stat.save
				@msgs[:successes] << "GameStat #{@game_stat.id} created."
			else
				@msgs[:errors] << "GameStat not created for UW #{@user_word.id}."
				@msgs[:errors] << @game_stat.errors.full_messages
			end

			if @free_w_r.save
				@free_w_r.game_stat = @game_stat
				@msgs[:successes] << "Free Word Rel created for UW #{@user_word.id}."
			else
				@msgs[:errors] << "Free Word Rel not created for UW #{@user_word.id}."
				@msgs[:errors] << @free_w_r.errors.full_messages
			end
		else
			@msgs[:errors] << "Freestyle not created for UW #{@user_word.id}."
			@msgs[:errors] << @free.errors.full_messages
		end

		render json: { response: @msgs }
	end

	def leksi_tale
		@game = Game.find_by(name: "Leksi Tale")
		@word = Word.find(params[:word_id])
		@user_word = UserWord.object(current_user, @word)
		@input = params[:uniq_data][:input]
		@free = Freestyle.new(input: @input, user_word: @user_word)
		@msgs = { successes: [], errors: [] }

		if @free.save
			@msgs[:successes] << "Free (#{@free.id}) created for UW #{@user_word.id}."
			@word_ids = params[:uniq_data][:word_ids]
			@free_l_t = FreestyleLekTale.new(freestyle: @free, word_ids: @word_ids)
			@game_stat = GameStat.universal(
				@user_word,
				@game,
				params[:time_started],
				params[:time_ended]
			)

			if @game_stat.save
				@msgs[:successes] << "GameStat #{@game_stat.id} created."
			else
				@msgs[:errors] << "GameStat not created for UW #{@user_word.id}."
				@msgs[:errors] << @game_stat.errors.full_messages
			end

			if @free_l_t.save
				@free_l_t.game_stat = @game_stat
				@msgs[:successes] << "Free Leksi Tale created for UW #{@user_word.id}."
			else
				@msgs[:errors] << "Free Leksi Tale not created for UW #{@user_word.id}."
				@msgs[:errors] << @free_l_t.errors.full_messages
			end
		else
			@msgs[:errors] << "Freestyle not created for UW #{@user_word.id}."
			@msgs[:errors] << @free.errors.full_messages
		end

		render json: { response: @msgs }
	end

	def describe_me
		@game = Game.find_by(name: "Describe Me, Describe Me Not")
		@word = Word.find(params[:word_id])
		@user_word = UserWord.object(current_user, @word)
		@input = params[:uniq_data][:input]
		@free = Freestyle.new(input: @input, user_word: @user_word)
		@msgs = { successes: [], errors: [] }

		if @free.save
			@msgs[:successes] << "Free (#{@free.id}) created for UW #{@user_word.id}."
			@desc_me = DescribeMe.find(params[:uniq_data][:desc_me_id])
			@f_desc_me = FreestyleDescMe.new(freestyle: @free, describe_me: @desc_me)
			@game_stat = GameStat.universal(
				@user_word,
				@game,
				params[:time_started],
				params[:time_ended]
			)

			if @game_stat.save
				@msgs[:successes] << "GameStat #{@game_stat.id} created."
			else
				@msgs[:errors] << "GameStat not created for UW #{@user_word.id}."
				@msgs[:errors] << @game_stat.errors.full_messages
			end

			if @f_desc_me.save
				@f_desc_me.game_stat = @game_stat
				@msgs[:successes] << "Free Desc Me created for UW #{@user_word.id}."
			else
				@msgs[:errors] << "Free Desc Me not created for UW #{@user_word.id}."
				@msgs[:errors] << @f_desc_me.errors.full_messages
			end
		else
			@msgs[:errors] << "Freestyle not created for UW #{@user_word.id}."
			@msgs[:errors] << @free.errors.full_messages
		end

		render json: { response: @msgs }
	end
end
