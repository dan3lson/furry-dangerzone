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
      mastery_circle_link_to(fund_game_link(word.id), "strength1", 0)
    elsif user_word.current_game == "two"
      mastery_circle_link_to(jeop_game_link(word.id), "strength2", 33)
    elsif user_word.current_game == "three"
      mastery_circle_link_to(free_game_link(word.id), "strength3", 66)
    else
      image_tag("strength4.png", alt: "100% Mastery")
    end
  end

  def mastery_circle_link_to(link, image_src, mastery_percentage)
    link_to link, class: "hover" do
      image_tag("#{image_src}.png", alt: "#{mastery_percentage}% Mastered")
    end
  end

  def random_congrats
    %w(
      Congratulations
      Awesome
      Nice
      Great
      Yay
      Kudos
      Groovy
      Props
      Terrific
      Excellent
      Outstanding
      Splendid
      Cool
      Fantastic
      Fabulous
      Exquisite
    ).sample
  end
end
