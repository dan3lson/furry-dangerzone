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
    current_user.word_sources.where(
      source: tag).map { |word_source| word_source.word.name }
  end

  def tags_for_a(word)
    tags_for_a_word = []
    current_user.user_word_sources.each do |user_word_source|
      current_user.sources.each do |source|
        if user_word_source.user == current_user &&
           user_word_source.word_source.word == word &&
           user_word_source.word_source.source == source
          tags_for_a_word << user_word_source.word_source.source
        end
      end
    end
    tags_for_a_word
  end

  def unused_tags(word)
    current_user.sources - tags_for_a(word)
  end
end
