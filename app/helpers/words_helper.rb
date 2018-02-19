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
  def array_of(word, attribute)
    word.send(attribute).split("***") unless word.send(attribute).empty?
  end

  def word_has_attribute_value?(result)
    return false if result.nil?
    result.class == String ? !result.empty? : result.any?
  end

  def attribute_is_synonym_or_antonym?(attribute)
    attribute.end_with?("onyms")
  end

  def thesuarus_names(word, syn_or_ant)
    # word.send(syn_or_ant).pluck(:name).uniq
    Thesaurus.send(syn_or_ant, word.name)
  end
end
