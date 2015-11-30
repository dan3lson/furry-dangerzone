class FlashcardsController < ApplicationController
	def study
		@tag = Tag.find(params[:tag_id])
		@words = words_for(current_user, @tag)
		@word_names = words_for(current_user, @tag).map { |w| w.name }
		@word_defs = words_for(current_user, @tag).map { |w| w.definition }

		current_user.num_flashcards_played += 1

		if current_user.save
			"Success: #{current_user.username}\'s num_flashcards_played updated."
		else
			"ERROR: #{current_user.username}\'s num_flashcards_played not updated."
		end

		render json: {
			word_names: @word_names,
			word_defs: @word_defs
		}
	end
end
