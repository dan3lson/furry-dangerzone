class CurrentUsersController < ApplicationController
  def words
    @current_user_words = current_user.words
  end

  def tags
    @current_user_tags = current_user.tags
  end
end
