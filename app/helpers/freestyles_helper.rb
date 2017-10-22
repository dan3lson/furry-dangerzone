module FreestylesHelper
  # TODO Create test
  def icon_and_status(free)
    color = free.status == "pass" ? "success" : "danger"
    direction = free.status == "pass" ? "--1" : "-1"
    content_tag(:span, nil, class: "") do
      emoji("#{direction}") + " #{free.status.capitalize}"
    end
  end

  # TODO Create test
  def display_content_status(created)
    if created
      content_tag(:i, nil, class: "fa fa-check text-success")
    else
      content_tag(:i, nil, class: "fa fa-close text-danger")
    end
  end

  # TODO Create test
  def free_game_num(game_name)
    if game_name == "Sentence Stems"
      9
    elsif game_name == "Word Relationships"
      10
    elsif game_name == "Leksi Tale"
      11
    elsif game_name == "Describe Me, Describe Me Not"
      12
    else
      13
    end
  end
end
