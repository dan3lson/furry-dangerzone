class GuestsController < ApplicationController
	def get_started
		@guest = User.new
		@new_weekly_goal = params[:weekly_goal]
		@four_random_words = Word.random(4)
	end
end
