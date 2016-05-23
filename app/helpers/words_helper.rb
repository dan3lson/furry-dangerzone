module WordsHelper
  def word_ids_for(user, tag)
    user.word_tags.joins(:word)
                  .order("words.name ASC")
                  .includes(:word)
                  .where(tag: tag)
                  .pluck(:word_id)
  end
  def words_for(user, tag)
    # user.word_tags.joins(:word)
    #               .order("words.name ASC")
    #               .includes(:word)
    #               .where(tag: tag)
    #               .map { |wt| wt.word }
                  Word.find(word_ids_for(user, tag))
  end
  # user.word_tags.joins(:word).order("words.name ASC").pluck(:word_id)

  # not tested
  def num_words_for(user, tag)
    words_for(user, tag).count
  end

  # not tested
  def tag_has_words?(user, tag)
    num_words_for(user, tag) > 0
  end

  # not tested
  def user_words(user, tag)
    # words_for(user, tag).map { |word| UserWord.object(user, word) }
    UserWord.where(user: user, word: word_ids_for(user, tag))
  end

  # not tested
  def completed_funds(user, tag)
    # user_words(user, tag).select { |uw| uw.fundamental_completed? }
    user_words(user, tag).completed_fundamentals
  end

  # not tested
  def completed_jeops(user, tag)
    # user_words(user, tag).select { |uw| uw.fundamental_completed? &&
    #   uw.jeopardy_completed?
    # }
    user_words(user, tag).completed_jeopardys
  end

  # not tested
  def completed_frees(user, tag)
    # user_words(user, tag).select { |uw| uw.freestyle_completed? }
    user_words(user, tag).completed_freestyles
  end

  # not tested
  def incomplete_fundamentals(user, tag)
    # user_words(user, tag).select { |uw| !uw.fundamental_completed? }
    user_words(user, tag).incomplete_fundamentals
  end

  # not tested
  def incomplete_jeopardys(user, tag)
    # user_words(user, tag).select { |uw| uw.jeopardy_not_completed? }
    user_words(user, tag).incomplete_jeopardys
  end

  # not tested
  def incomplete_freestyles(user, tag)
    # user_words(user, tag).select { |uw| uw.freestyle_not_completed? }
    user_words(user, tag).incomplete_freestyles
  end

  # not tested
  def incomplete_fundamentals_exist?(user, tag)
    incomplete_fundamentals(user, tag).count > 0
  end

  # not tested
  def incomplete_jeopardys_exist?(user, tag)
    incomplete_jeopardys(user, tag).count > 0
  end

  # not tested
  def incomplete_freestyles_exist?(user, tag)
    incomplete_freestyles(user, tag).count > 0
  end

  # not tested
  def enough_jeopardy_words_exist?(user, tag)
    incomplete_jeopardys(user, tag).count + completed_jeops(user, tag).count > 3
  end

  # not tested
  def array_of(word, attribute)
    word.send(attribute).split("***")
  end

  def word_has_attribute_value?(result)
    return false if result.nil?

    result.class == String ? !result.empty? : result.any?
  end

  def attribute_is_example_sentence_or_definition?(attribute)
    attribute == "example_sentence" || attribute == "definition"
  end

  def attribute_is_synonym_or_antonym?(attribute)
    attribute.end_with?("onyms")
  end

  def thesuarus_names(word, syn_or_ant)
    word.send(syn_or_ant).pluck(:name).uniq
  end
end
