module ApplicationHelper
  def full_title(title)
    if title.empty?
      title = "Leksi"
    else
      "Leksi | " << title
    end
  end

  def full_header(header)
    if header.empty?
      header = ""
    else
      header
    end
  end

  def right_header_button(value, path)
    content_tag(:span, class: "pull-right") do
      content_tag(:a)
    end
  end

  def words_for(user, tag)
    user.word_tags.where(tag: tag).map { |word_tag| word_tag.word }
  end

  def tags_for_a(user, word)
    user.user_word_tags.map do |uwt|
      uwt.word_tag.tag if uwt.word_tag.word == word
    end.compact
  end

  def unused_tags(user, word)
    user.tags - tags_for_a(user, word)
  end
end
