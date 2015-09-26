module TagsHelper
  def tags_for_a(user, word)
    user.user_word_tags.map do |uwt|
      uwt.word_tag.tag if uwt.word_tag.word == word
    end.compact
  end

  def unused_tags(user, word)
    user.tags - tags_for_a(user, word)
  end
end
