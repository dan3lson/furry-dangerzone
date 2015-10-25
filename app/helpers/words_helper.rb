module WordsHelper
  def words_for(user, tag)
    user.word_tags.where(tag: tag).map { |word_tag| word_tag.word }
  end

  def user_words(user, tag)
    words_for(user, tag).map { |w| UserWord.find_by(user: user, word: w) }
  end

  def incomplete_fundamentals(user, tag)
    user_words(user, tag).select { |uw| !uw.fundamental_completed? }
  end

  def incomplete_fundamentals_exist?(user, tag)
    incomplete_fundamentals(user, tag).count > 0
  end

  def top_three_entries_for(word, attribute)
    word.send(attribute).split(";").take(3)
  end
end
