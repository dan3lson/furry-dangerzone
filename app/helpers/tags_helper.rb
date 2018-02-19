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
end
