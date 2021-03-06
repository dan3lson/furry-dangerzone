class MyLeksiController < ApplicationController
	before_action :logged_in_user

	def index
		@user_words = UserWord.where(user: current_user)
												  .alphabetical
												  .includes(:word)
	end

	def show
		@word = Word.find(params[:id])
		@user_word = UserWord.object(current_user, @word)
	end

	def words
		@target_word = Word.find(params[:word_id])
		@words = if current_user.num_words > 3
			UserWord.where(user: current_user)
							.includes(:word)
							.map(&:word)
		else
			Word.random(4)
		end

		render json: @words << @target_word
	end

	private

	def logged_in_user
		unless logged_in?
			flash[:danger] = "Please log in first."
			redirect_to login_url
		end
	end

end
