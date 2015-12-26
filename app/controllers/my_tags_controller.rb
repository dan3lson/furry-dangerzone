class MyTagsController < ApplicationController
	def index
		@current_user_tags = current_user.tags.alphabetical
		@tag = Tag.new
	end

	def random_word
		@tag = Tag.find(params[:tag_id])
		@activity = params[:activity]

		@random_word = if @activity == "fund"
									   incomplete_fundamentals(current_user, @tag).sample
									 elsif @activity == "jeop"
										 incomplete_jeopardys(current_user, @tag).sample
									 elsif @activity == "free"
										 incomplete_freestyles(current_user, @tag).sample
									 end.word

		render json: { random_word: @random_word }
	end
end
