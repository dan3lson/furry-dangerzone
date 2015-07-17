class CurrentUsersController < ApplicationController
  def words
    @current_user_words = current_user.words
  end

  def sources
    @current_user_sources = current_user.sources
  end
end
