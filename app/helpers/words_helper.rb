module WordsHelper
  def words_for(user, tag)
    user.word_tags.where(tag: tag).map { |word_tag| word_tag.word }
  end

  def top_three_entries_for(word, attribute)
    word.send(attribute).split(";").take(3)
  end
end
