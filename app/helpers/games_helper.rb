module GamesHelper
  def num_fundamentals_games_not_started(user)
    user.incomplete_fundamentals.count
  end

  def num_fundamentals_games_completed(user)
    user.completed_fundamentals.count
  end

  def num_jeopardy_games_not_started(user)
    user.incomplete_jeopardys.count
  end

  def num_jeopardy_games_completed(user)
    user.completed_jeopardys.count
  end

  def num_freestyle_games_not_started(user)
    user.incomplete_freestyles.count
  end

  def num_freestyle_games_completed(user)
    user.completed_freestyles.count
  end
end
