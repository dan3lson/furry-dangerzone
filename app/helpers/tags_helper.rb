module TagsHelper
  def tags_for(user, word)
    Tag.includes(:words).select { |t| t.words.include?(word) &&
      user.words.include?(word)
    }.keep_if { |t| user.tags.include?(t) && UserWordTag.find_by(
        user: user,
        word_tag: WordTag.find_by(word: word, tag: t)
      )
    }
  end

  def tags_exist?(user, word)
    tags_for(user, word).count > 0
  end

  def unused_tags(user, word)
    user.tags - tags_for(user, word)
  end
end
