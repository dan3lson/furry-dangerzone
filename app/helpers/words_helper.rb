module WordsHelper
  def myLeksi_show_path(word)
    "/myLeksi/#{word.id}"
  end
  def word_ids_for(user, tag)
    user.word_ids_for(tag)
  end

  # TODO: Create test
  def words_for(user, tag)
    Word.find(word_ids_for(user, tag))
  end

  # TODO: Create test
  def num_words_for(user, tag)
    words_for(user, tag).count
  end

  # TODO: Create test
  def tag_has_words?(user, tag)
    num_words_for(user, tag) > 0
  end

  # TODO: Create test
  def user_words(user, tag)
    UserWord.where(user: user, word: word_ids_for(user, tag))
  end

  # TODO: Create test
  def completed_fundamentals(user, tag)
    user_words(user, tag).completed_fundamentals
  end

  # TODO: Create test
  def completed_jeopardys(user, tag)
    user_words(user, tag).completed_jeopardys
  end

  # TODO: Create test
  def completed_freestyles(user, tag)
    user_words(user, tag).completed_freestyles
  end

  # TODO: Create test
  def incomplete_fundamentals(user, tag)
    user_words(user, tag).incomplete_fundamentals
  end

  # TODO: Create test
  def incomplete_jeopardys(user, tag)
    user_words(user, tag).incomplete_jeopardys
  end

  # TODO: Create test
  def incomplete_freestyles(user, tag)
    user_words(user, tag).incomplete_freestyles
  end

  # TODO: Create test
  def incomplete_and_complete_jeopardys(user, tag)
    user_words = user_words(user, tag)
    user_words.incomplete_jeopardys +
    user_words.completed_jeopardys
  end

  # TODO: Create test
  def incomplete_and_complete_jeopardy_word_ids(user, tag, word)
    user_words = user_words(user, tag)
    user_words = user_words.incomplete_jeopardys +
                 user_words.completed_jeopardys
    UserWord.where(id: user_words.map(&:id))
            .where.not(word_id: word.id)
            .pluck(:word_id)
  end

  # TODO: Create test
  def get_jeop_words_tag(user, tag, word)
    ids = incomplete_and_complete_jeopardy_word_ids(user, tag, word)
    Word.where(id: ids).order("RANDOM()").limit(3)
  end

  # TODO: Create test
  def incomplete_fundamentals_exist?(user, tag)
    incomplete_fundamentals(user, tag).count > 0
  end

  # TODO: Create test
  def incomplete_jeopardys_exist?(user, tag)
    incomplete_jeopardys(user, tag).count > 0
  end

  # TODO: Create test
  def completed_jeopardys_exist?(user, tag)
    completed_jeopardys(user, tag).any?
  end

  # TODO: Create test
  def incomplete_freestyles_exist?(user, tag)
    incomplete_freestyles(user, tag).count > 0
  end

  # TODO: Create test
  def enough_jeopardy_words_exist?(user, tag)
    incomplete_jeopardys(user, tag).count +
    completed_jeopardys(user, tag).count > 3
  end

  # TODO: Create test
  def array_of(word, attribute)
    word.send(attribute).split("***") unless word.send(attribute).empty?
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
    # word.send(syn_or_ant).pluck(:name).uniq
    Thesaurus.send(syn_or_ant, word.name)
  end
end
