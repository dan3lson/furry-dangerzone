module UserWordHelper
  def ready_for_jeopardy?(user, user_word)
    user_word.fundamental_completed? && user_word.jeopardy_not_completed? &&
    user.has_enough_jeopardy_words?
  end
end
