class GuestsController < ApplicationController
	def get_started
		@words = Word.random(5)
		@first_row_rand_words = @words[0..1]
		@second_row_rand_words = @words[2..4]
		@user = User.new
	end

	def game_zone
		@words = Word.random(5)
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
end
