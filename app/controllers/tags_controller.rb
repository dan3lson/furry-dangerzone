class TagsController < ApplicationController
	before_action :logged_in_user

	def index
		@user_words = current_user.user_words_with_tags
	end

	private

	def logged_in_user
		unless logged_in?
			flash[:danger] = "Please log in first to see your tags."
			redirect_to login_url
		end
	end
end
