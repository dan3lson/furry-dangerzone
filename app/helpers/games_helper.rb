module GamesHelper
  def fund_game_link(word_id)
    "/fundamentals?word_id=#{word_id}"
  end

  def jeop_game_link(word_id)
    "/jeopardy?word_id=#{word_id}"
  end

  def free_game_link(word_id)
    "/freestyle?word_id=#{word_id}"
  end

  def play_btn_big(user_word, word_id)
    if user_word.freestyle_completed?
      link_to_big_btn("#", "info", user_word)
    elsif user_word.fundamental_not_completed?
      link_to_big_btn(fund_game_link(word_id), "danger", user_word)
    elsif user_word.jeopardy_not_completed?
      link_to_big_btn(jeop_game_link(word_id), "warning", user_word)
    elsif user_word.jeopardy_completed?
      link_to_big_btn(free_game_link(word_id), "success", user_word)
    end
  end

  def play_btn_small(user_word, word_id)
    if user_word.freestyle_completed?
      link_to_small_btn("#", "info", user_word)
    elsif user_word.fundamental_not_completed?
      link_to_small_btn(fund_game_link(word_id), "danger", user_word)
    elsif user_word.jeopardy_not_completed?
      link_to_small_btn(jeop_game_link(word_id), "warning", user_word)
    elsif user_word.jeopardy_completed?
      link_to_small_btn(free_game_link(word_id), "success", user_word)
    end
  end

  def link_to_big_btn(path, color, user_word)
    link_to path,
            class: "btn btn-#{color} btn-block",
            role: "button",
            remote: true do
      content_tag(:h1, nil, class: "display-5") do
        content_tag(:small, user_word.word.name, class: "card-inverse") +
        tag(:br) +
        play_icon + " #{user_word.game}"
      end
    end
  end

  def link_to_small_btn(path, color, user_word)
    link_to path,
            class: "btn btn-#{color} btn-block",
            role: "button",
            remote: true do
      play_icon + " #{user_word.game}"
    end
  end

  def play_icon
    icon("play-circle")
  end

  def random_congrats
    [
      "Awesome",
      "Congratulations",
      "Cool",
      "Excellent",
      "Exquisite",
      "Fantastic",
      "Fabulous",
      "Great",
      "Groovy",
      "Keep it up",
      "Kudos",
      "Nice",
      "Outstanding",
      "Props",
      "Splendid",
      "Terrific",
      "Way to go",
      "Yay"
    ].sample
  end
end
