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

  def words_for_a(tag)

    tag.words.map { |word| word }.keep_if { |word|
      current_user.words.include?(word)
    }
  end

  def tags_for_a(word)
    word.sources.map { |source| source }.keep_if { |source|
      current_user.sources.include?(source)
    }
  end

  def unused_tags(word)
    current_user.sources - tags_for_a(word)
  end
end
