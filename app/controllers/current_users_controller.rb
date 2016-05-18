class CurrentUsersController < ApplicationController
  before_action :logged_in_user

  def home
    if current_user.has_games_to_play?
      @incomplete_games = UserWord.where(user: current_user).
                                   where.not(games_completed: 3)

      @rand_word = @incomplete_games.sample.word
      @rand_word_uw = UserWord.object(current_user, @rand_word)

      @game_zone_user_words = @incomplete_games.shuffle[0..9]

      @first_row_rand_words = @game_zone_user_words[0..1]
      @second_row_rand_words = @game_zone_user_words[2..4]
      @third_row_rand_words = @game_zone_user_words[5..7]
      @fourth_row_rand_words = @game_zone_user_words[8..9]
    end

    @three_rand_tags = Tag.joins(:users).where(users: {
        username: current_user.username
      }
    ).limit(3).order("RANDOM()")

    @tag_game_progress_pcts = @three_rand_tags.map do |t|
      words_count = words_for(current_user, t).count

      if words_count > 0
        completed_games_count = completed_funds(current_user, t).count +
                                completed_jeops(current_user, t).count +
                                completed_frees(current_user, t).count
        total_games = words_count * 3

        (completed_games_count / total_games.to_f * 100).round
      end
    end
  end

  def menu
    @review = Review.new
    @feedback = Feedback.new
  end

  def myLeksi
    @current_user_words = current_user.sort_progress("ASC")
                                      .includes(:word)
                                      .map { |uw| uw.word }
    page = params[:page] ? params[:page].to_i - 1 : 1
    @current_user_words_pag = @current_user_words.paginate(
      page: page,
      per_page: 15
    )
    @current_user_words_count = @current_user_words.count

    # http://jsfiddle.net/Unspecified/uVH8s/
    # http://codepen.io/johno/pen/LkaiI
    respond_to do |format|
      format.html
      format.js
    end
  end

  def progress
    @gold_user = User.top_ten_highest_points[0]
    @silver_user = User.top_ten_highest_points[1]
    @bronze_user = User.top_ten_highest_points[2]
    @seven_through_ten_users = User.top_ten_highest_points.drop(3)
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Yikes! Please log in first to do that."

      redirect_to login_url
    end
  end
end
