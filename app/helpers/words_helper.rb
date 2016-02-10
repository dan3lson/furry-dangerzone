module WordsHelper
  def words_for(user, tag)
    user.word_tags.includes(:word).where(tag: tag).map { |word_tag|
      word_tag.word
    }
  end

  # not tested
  def num_words_for(user, tag)
    words_for(user, tag).count
  end

  # not tested
  def tag_has_words?(user, tag)
    num_words_for(user, tag) > 0
  end

  def user_words(user, tag)
    words_for(user, tag).map { |w| UserWord.find_by(user: user, word: w) }
  end

  def completed_funds(user, tag)
    user_words(user, tag).select { |uw| uw.fundamental_completed? }
  end

  def completed_jeops(user, tag)
    user_words(user, tag).select { |uw| uw.fundamental_completed? &&
      uw.jeopardy_completed?
    }
  end

  def completed_frees(user, tag)
    user_words(user, tag).select { |uw| uw.freestyle_completed? }
  end

  def incomplete_fundamentals(user, tag)
    user_words(user, tag).select { |uw| !uw.fundamental_completed? }
  end

  def incomplete_jeopardys(user, tag)
    user_words(user, tag).select { |uw| uw.jeopardy_not_completed? }
  end

  def incomplete_freestyles(user, tag)
    user_words(user, tag).select { |uw| uw.freestyle_not_completed? }
  end

  def incomplete_fundamentals_exist?(user, tag)
    incomplete_fundamentals(user, tag).count > 0
  end

  def incomplete_jeopardys_exist?(user, tag)
    incomplete_jeopardys(user, tag).count > 0
  end

  def incomplete_freestyles_exist?(user, tag)
    incomplete_freestyles(user, tag).count > 0
  end

  def enough_jeopardy_words_exist?(user, tag)
    incomplete_jeopardys(user, tag).count + completed_jeops(user, tag).count > 3
  end

  def top_three_entries_for(word, attribute)
    word.send(attribute).split("***").take(3)
  end
end
