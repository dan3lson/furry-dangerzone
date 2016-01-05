class GuestsController < ApplicationController
	def get_started
		@words = Word.random(5)
		@word_ids = @words.map { |w| w.id }
		@first_row_rand_words = @words[0..1]
		@second_row_rand_words = @words[2..4]
		@user = User.new
	end

	def game_zone
		@words = Word.random(5)
		@word_ids = @words.map { |w| w.id }
		@first_row_rand_words = @words[0..1]
		@second_row_rand_words = @words[2..4]

		respond_to do |format|
			format.js
		end
	end

	def fundamentals
		@word = Word.find(params[:word_id])
    @synonyms = @word.synonyms if @word.has_synonyms?
    @antonyms = @word.antonyms if @word.has_antonyms?
    @real_world_examples = RealWorldExample.for(@word.name)
    @record = true

		respond_to do |format|
			format.js
		end
	end

	def save_progress
		@goal = params[:weekly_goal]
		@words = params[:word_ids]
		@completed_fund = params[:completed_fund]
	end

	def update
		@attribute = params[:attribute].gsub("-", "_")
		@get_started_record = GetStartedStat.first || GetStartedStat.new
		@num = @get_started_record.send(@attribute) + 1
		@result = @get_started_record.update_attributes(@attribute.to_sym => @num)

		if @result
			render json: {
				errors: "Success: get started stat #{@attribute} updated."
			}
		else
			render json: {
				errors: "ERROR: get started stat #{@attribute} not updated."
			}
		end
	end
end
