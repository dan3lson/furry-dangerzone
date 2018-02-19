class MyTagsController < ApplicationController
	before_action :logged_in_user

	def index
		@current_user_tags = UserTag.where(user: current_user)
																.alphabetical
																.includes(:tag)
																.map(&:tag)
		@num_current_user_tags = @current_user_tags.count
		@tag = Tag.new
	end

	def show
		@tag = Tag.find(params[:id])
	end

	private

	def logged_in_user
		unless logged_in?
			flash[:danger] = "Please log in first to see your tags."

			redirect_to login_url
		end
	end
end
