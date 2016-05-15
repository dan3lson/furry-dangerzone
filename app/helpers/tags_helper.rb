module TagsHelper
  # In desperate need of refactor
  def tags_for(user, word)
    Tag.includes(:words).select do |t|
      t.words.include?(word) &&
      user.words.include?(word)
    end.keep_if { |t| user.tags.include?(t) && UserWordTag.find_by(
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

  # not tested
  def progress_for(user, tag)
    num_words_for_tag = words_for(current_user, tag).count

    if num_words_for_tag > 0
      completed_games = completed_funds(current_user, tag).count +
                        completed_jeops(current_user, tag).count +
                        completed_frees(current_user, tag).count
      total_games = num_words_for_tag * 3
      (completed_games / total_games.to_f * 100).round
    else
      0
    end
  end
end
