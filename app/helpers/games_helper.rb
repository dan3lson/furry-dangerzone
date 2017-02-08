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
