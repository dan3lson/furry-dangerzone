class CurrentUsersController < ApplicationController
  def home
  end

  def words
    @current_user_user_words = current_user.user_words.sort_by { |uw|
      uw.word.name
    }
  end

  def progress
    @gold_user = User.top_ten_highest_points[0]
    @silver_user = User.top_ten_highest_points[1]
    @bronze_user = User.top_ten_highest_points[2]
    @seven_through_ten_users = User.top_ten_highest_points.drop(3)
  end

  def tags
    @current_user_tags = current_user.tags
  end
end
