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

  def percentage_of_freestyle_games_completed(user)
    completed = num_freestyle_games_completed(user)
    not_started = num_freestyle_games_not_started(user)
    total = completed + not_started

    (completed / total.to_f * 100).round
  end

  def percentage_of_jeopardy_games_completed(user)
    completed = num_jeopardy_games_completed(user)
    not_started = num_jeopardy_games_not_started(user)
    total = completed + not_started

    (completed / total.to_f * 100).round
  end

  def percentage_of_freestyle_games_completed(user)
    completed = num_freestyle_games_completed(user)
    not_started = num_freestyle_games_not_started(user)
    total = completed + not_started

    (completed / total.to_f * 100).round
  end

  def fund_game_link(word_id)
    "/fundamentals?word_id=#{word_id}"
  end

  def jeop_game_link(word_id)
    "/jeopardy?word_id=#{word_id}"
  end

  def free_game_link(word_id)
    "/freestyle?word_id=#{word_id}"
  end

  def mastery_circle(word, user_word)
    if user_word.current_game == "one"
      mastery_circle_link_to(fund_game_link(word.id), "0_big", 0)
    elsif user_word.current_game == "two"
      mastery_circle_link_to(jeop_game_link(word.id), "33_big", 33)
    elsif user_word.current_game == "three"
      mastery_circle_link_to(free_game_link(word.id), "66_big", 66)
    else
      image_tag("100_big.png", alt: "100% Mastery")
    end
  end

  def mastery_circle_link_to(link, image_src, mastery_percentage)
    link_to link, class: "hover" do
      image_tag("#{image_src}.png", alt: "#{mastery_percentage}% Mastered")
    end
  end
end
