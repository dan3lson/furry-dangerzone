class TagsController < ApplicationController
	before_action :logged_in_user

	def index
		@user_words_ids = current_user.user_words_with_tags.pluck(:id)
		@user_tag_ids = UserWordUserTag.where(user_word: @user_words_ids)
																	 .pluck(:user_tag_id)
																	 .uniq
    @user_tags = UserTag.find(@user_tag_ids)
	end

	private

	def logged_in_user
		unless logged_in?
			flash[:danger] = "Please log in first to see your tags."
			redirect_to login_url
		end
	end
end
