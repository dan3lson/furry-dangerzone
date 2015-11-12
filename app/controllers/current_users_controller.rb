class CurrentUsersController < ApplicationController
  before_action :logged_in_user

  def home
    @incomplete_fundamentals = current_user.incomplete_fundamentals
    @incomplete_jeopardys = current_user.incomplete_jeopardys
    @incomplete_freestyles = current_user.incomplete_freestyles

    if current_user.has_words?
      @incomplete_games = UserWord.includes(:user, :word).select { |uw|
        uw.user == current_user && (uw.fundamental_not_completed? ||
                                    uw.jeopardy_not_completed? ||
                                    uw.freestyle_not_completed?)
      }
    else
      @incomplete_games = UserWord.includes(:user).select { |uw|
        uw.user == current_user && (uw.fundamental_not_completed? ||
                                    uw.jeopardy_not_completed? ||
                                    uw.freestyle_not_completed?)
      }
    end

    @rand_word = @incomplete_games.sample
    @incomplete_games_num = @incomplete_games.count
    @nudges_needed = 10 - @incomplete_games_num if @incomplete_games_num < 10

    @game_zone_user_words = @incomplete_games.shuffle[0..9]

    if @incomplete_games_num > 0
      @first_row_rand_words = @game_zone_user_words[0..1]

      if @first_row_rand_words.count == 2
        @first_row_rand_words
      else
        (2 - @first_row_rand_words.count).times do
          @first_row_rand_words << "nudge user to add new word"
        end
      end
    else
      @first_row_rand_words = ["nudge user to add new word"] * 2
    end

    if @incomplete_games_num > 2
      @second_row_rand_words = @game_zone_user_words[2..4]

      if @second_row_rand_words.count == 3
        @second_row_rand_words
      else
        (3 - @second_row_rand_words.count).times do
          @second_row_rand_words << "nudge user to add new word"
        end
      end
    else
      @second_row_rand_words = ["nudge user to add new word"] * 3
    end

    if @incomplete_games_num > 5
      @third_row_rand_words = @game_zone_user_words[5..7]

      if @third_row_rand_words.count == 3
        @third_row_rand_words
      else
        (3 - @third_row_rand_words.count).times do
          @third_row_rand_words << "nudge user to add new word"
        end
      end
    else
      @third_row_rand_words = ["nudge user to add new word"] * 3
    end

    if @incomplete_games_num > 8
      @fourth_row_rand_words = @game_zone_user_words[8..9]

      if @fourth_row_rand_words.count == 2
        @fourth_row_rand_words
      else
        (2 - @fourth_row_rand_words.count).times do
          @fourth_row_rand_words << "nudge user to add new word"
        end
      end
    else
      @fourth_row_rand_words = ["nudge user to add new word"] * 2
    end

    @three_rand_tags = Tag.includes(:users).select do |t|
      t.users.include?(current_user)
    end.shuffle.take(3)

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

    @tag = Tag.new
  end

  def menu
    @review = Review.new
    @feedback = Feedback.new
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
    @tag = Tag.new
  end

  def weekly_goal
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Yikes! Please log in first to do that."

      redirect_to login_url
    end
  end
end
