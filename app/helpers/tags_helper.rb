module TagsHelper
  def tags_for(user, word)
    user.word_tags.joins(:tag)
                  .order("tags.name ASC")
                  .includes(:tag)
                  .where(word: word)
                  .map { |wt| wt.tag }
  end

  def tags_exist?(user, word)
    tags_for(user, word).count > 0
  end

  def unused_tags(user, word)
    user.tags - tags_for(user, word)
  end

  # TODO: Create test
  def progress_for(user, tag)
    num_words = num_words_for(user, tag)
    return 0 if num_words < 1
    completed_games = user_words(user, tag).completed_freestyles.count
    total_games = num_words * 12
    (completed_games / total_games.to_f * 100).round
  end
end
