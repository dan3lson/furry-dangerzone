module UserWordHelper
  def myLeksi_jeop_ready?(user, user_word)
    user_word.jeopardy_not_completed? && user.has_enough_incomplete_jeops?
  end
end
