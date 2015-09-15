class CurrentUsersController < ApplicationController
  def home
    @incomplete_games = current_user.incomplete_fundamentals.take(3).
      sort_by { |uw| uw.word.name }

    @rand_word_id =
      if current_user.has_words? && current_user.has_incomplete_fundamentals?
        current_user.incomplete_fundamentals.sample.word.id
      else
        Word.all.sample.id
    end
  end

  def menu
    @review = Review.new
  end
  
  def myLeksi
    @current_user_user_words = current_user.user_words.sort_by { |uw|
      uw.word.name
    }
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

end
