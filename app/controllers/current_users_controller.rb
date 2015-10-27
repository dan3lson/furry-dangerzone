class CurrentUsersController < ApplicationController
  before_action :logged_in_user

  def home
    @incomplete_fundamentals = current_user.incomplete_fundamentals
    @incomplete_jeopardys = current_user.incomplete_jeopardys
    @incomplete_freestyles = current_user.incomplete_freestyles
    @shuffled_incomplete_games = UserWord.includes(:user, :word).select { |uw|
      uw.user == current_user && (uw.fundamental_not_started? ||
                                  uw.jeopardy_not_started? ||
                                  uw.freestyle_not_started?)
    }.shuffle[0..3].sort_by { |uw| uw.word.name }
  end

  def menu
    @review = Review.new
  end

  def myLeksi
    @current_user_user_words = UserWord.includes(:word).where(
      user: current_user
    ).sort_by { |uw| uw.word.name }

    @current_user_words_count = current_user.words.count

    if current_user.has_words?
      @first_word_letter = @current_user_user_words[0].word.name[0].capitalize
    end
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

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Yikes! Please log in first to do that."
      redirect_to login_url
    end
  end
end
