class CurrentUsersController < ApplicationController
  def home
  end

  def words
    @current_user_user_words = current_user.user_words.sort_by { |uw|
      uw.word.name
    }
  end

  def progress
  end

  def tags
    @current_user_tags = current_user.tags
  end
end
