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
