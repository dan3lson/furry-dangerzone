module GamesHelper
  def num_fundamentals_games_not_started(user)
    num = 0

    user.user_words.each do |uw|
      num += 1 if uw.fundamentals_not_started?
    end

    num
  end

  def num_fundamentals_games_in_progress(user)
    num = 0

    user.user_words.each do |uw|
      num += 1 if uw.fundamentals_in_progress?
    end

    num
  end

  def num_fundamentals_games_completed(user)
    num = 0

    user.user_words.each do |uw|
      num += 1 if uw.fundamentals_completed?
    end
    num
  end

  def num_jeopardy_games_not_started(user)
    num = 0

    user.user_words.each do |uw|
      num += 1 if uw.jeopardy_not_started?
    end

    num
  end

  def num_jeopardy_games_completed(user)
    num = 0

    user.user_words.each do |uw|
      num += 1 if uw.jeopardy_completed?
    end

    num
  end

  def num_freestyle_games_not_started(user)
    num = 0

    user.user_words.each do |uw|
      num += 1 if uw.freestyle_not_started?
    end

    num
  end

  def num_freestyle_games_completed(user)
    num = 0

    user.user_words.each do |uw|
      num += 1 if uw.freestyle_completed?
    end

    num
  end
end
