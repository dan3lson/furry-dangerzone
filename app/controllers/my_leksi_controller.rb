class MyLeksiController < ApplicationController
	before_action :logged_in_user

	def index
		# @current_user_words = current_user.sort_words_by_progress("ASC")
		# 																	.includes(:word)
		# 																	.map(&:word)
		@current_user_user_words = UserWord.where(user: current_user)
																			 .includes(:word)
																			 .latest
																			 .alphabetical
		page = params[:page] ? params[:page].to_i - 1 : 1
		@current_user_user_words_pag = @current_user_user_words.paginate(
			page: page,
			per_page: 12
		)
		@current_user_words_count = @current_user_user_words.count

		respond_to do |format|
			format.html
			format.js
		end
	end

	def show
		@word = Word.find(params[:id])
		@user_word = UserWord.object(current_user, @word)
	end

	def names
		render json: UserWord.where(user: current_user)
												 .includes(:word)
												 .map(&:word)
												 .map(&:name)
	end

	private

	def logged_in_user
		unless logged_in?
			flash[:danger] = "Please log in first to see your words."

			redirect_to login_url
		end
	end

end
